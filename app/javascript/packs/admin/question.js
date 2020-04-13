window.onload = function(){
  var reqs_id = 0;
  // **【buttun押下時の処理】**
  document.getElementById("add_similar_word_button").onclick = function() {
    reqs_id++;
    const li2 = document.getElementById("li2");
    const input1 = document.createElement("input");
    input1.id = "question_question_similar_words_attributes_" + 0 + reqs_id + "_similar_word"; 
    input1.name = "question[question_similar_words_attributes][" + 0 + reqs_id + "][similar_word]";
    input1.setAttribute("type","text"); 
    li2.appendChild(input1);
  }
  function delete_element(){
    li2.removeChild(li2.firstChild);
  }
  var delete_value = document.getElementById('remove_similar_word_button');
    delete_value.addEventListener('click', delete_element, false);
}