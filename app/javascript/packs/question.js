window.onload = function(){
  let correct_answer = ""
  let Qcnt = 1;
  let allQuestionDate = [];

  //Ajax通信
  //Jsondataを受け取る
  const fetchAllQuestions = () => {
    const DATE_URL = '/questions.json'
    return fetch(DATE_URL)
    .then(function(response) {
        return response.json();
    })
  }

  fetchAllQuestions().then(allQuestion => {
    allQuestionDate = allQuestion
    correct_answer = allQuestionDate[Qcnt][2]
    outputQuestion(allQuestionDate, Qcnt);
    //何問目か表示
    document.getElementById("span1").textContent = Qcnt
  })

  // **【buttun押下時の処理】**
  document.getElementById("button").onclick = function() {
    
    correct_answer = allQuestionDate[Qcnt][2]
    // form要素を取得
    var element = document.getElementById( "description_id" ) ;
    // form要素内のラジオボタングループ(name="hoge")を取得
    var radioNodeList = element.description ;
    // 選択状態の値(value)を取得
    var answer = radioNodeList.value ;
    checkAnswer(answer, correct_answer)

    Qcnt ++;
    document.getElementById("span1").textContent = Qcnt

    if (Qcnt == 50){
      
      //Ajax通信
      //セッションの正解数をcontroller側へ渡す
      var myHeaders = new Headers({ "Content-type" : "application/json" });
      myHeaders.append("X-CSRF-Token", getCsrfToken());
      fetch('/users/api',{
        method: 'POST',
        body: JSON.stringify({ answer_count: window.sessionStorage.getItem('correct_answer_count')}),
        headers : myHeaders,
        credentials: 'same-origin'
      })
      .then(response => response.text())
      .then(_text => {
        window.sessionStorage.setItem('correct_answer_count', 0);
        window.sessionStorage.setItem('incorrect_answer_count', 0);
        //ランキングに画面遷移
        window.location.href = '/ranking?completed=true'
      });
    }

    //radioボタンの初期化
    const el = document.getElementById('description_id');
    el.innerHTML = '';
    
    outputQuestion(allQuestionDate, Qcnt)
  } 
};

 // **【問題と解答の出力】**
const outputQuestion = (jsonData, Qcnt) => {
  const question = document.getElementById('one_question');
  const similar_word = document.getElementById('similar_word');
  question.textContent = jsonData[Qcnt][1];
  similar_word.textContent = jsonData[Qcnt][3];
  generateAnswers(jsonData, Qcnt)
}

// **【回答のradioボタンの選択肢3つを作成する】**
const generateAnswers = (jsonData, Qcnt) => {
  const descriptionArr = [];
  const descriptionEl = document.getElementById('description_id');
  const descriptionArrAll = [];
  //正解を保持
  correct_answer = jsonData[Qcnt][2]
  descriptionArr.push(correct_answer);

  //jsonDate50件から回答のみをArrayにセット
  for (var i = 0; i < jsonData.length; i++) {
    description = jsonData[i][2]
    descriptionArrAll.push(description);
  }
    
  //descriptionArrからランダムで2解答追加(かぶらないもの)
  const copy = descriptionArrAll.slice();
  random = [...Array(3)].map(() => copy.splice(Math.floor(Math.random() * copy.length), 1)[0]);

  for (var i = 0; i < random.length; i++) {
    description = random[i]
    if (correct_answer !== description){
      descriptionArr.push(description);
      if (descriptionArr.length == 3){
        break;
      }
    } 
  }

  // 回答のradioボタンをシャッフルする
  for (var i = descriptionArr.length -1; i > 0; i--){
    var r = Math.floor(Math.random() * (i+1));
    var tmp = descriptionArr[i];
    descriptionArr[i] = descriptionArr[r]
    descriptionArr[r] = tmp
  }

  // 選択肢３つのradioボタンの作成
  descriptionArr.forEach(descriptionChild => {
    const radio = createRadio("description", descriptionChild)
    const radio_label = document.createElement('label')
    descriptionEl.appendChild(radio_label); //ない
    radio_label.appendChild(radio)
    radio_label.appendChild(document.createTextNode(descriptionChild))
  });
}
  // **【radioボタン要素作成】**
  const createRadio = (name, value) => {
    const input_radio = document.createElement('input');
    input_radio.type = "radio";
    input_radio.name = name;
    input_radio.value = value;
  return input_radio
}

// **【回答をチェックする】**
const checkAnswer = (answer ,correct_answer) => {
  if (answer === correct_answer){
    // 正解数のセッションに +1をする
    correct_answer_count = window.sessionStorage.getItem('correct_answer_count');
    window.sessionStorage.setItem('correct_answer_count', Number(correct_answer_count) + 1);
  
  } else {
    // 不正回数のセッションに +1をする
    incorrect_answer_count = sessionStorage.getItem('incorrect_answer_count');
    window.sessionStorage.setItem('incorrect_answer_count', Number(incorrect_answer_count) + 1);
    alert("不正解");
  }
}

const getCsrfToken = () => {
  const metas = document.getElementsByTagName('meta');
  for (let meta of metas) {
      if (meta.getAttribute('name') === 'csrf-token') {
          console.log(meta.getAttribute('content'));
          return meta.getAttribute('content');
      }
  }
  return '';
}