(() => {
  const BACKSPACE = 8;
  const pitchInput = document.querySelector("#candidate_pitch"),
        pitchCounter = document.querySelector("#pitch_counter");

  if (pitchInput && pitchCounter) {
    pitchInput.addEventListener("input", (event) => {
      const {textLength} = pitchInput;
      
      if (textLength === 140) {
        const {keyCode} = event;
        if (keyCode !== BACKSPACE) {
          pitchInput.value = pitchInput.value.substring(0, textLength - 1);
        }
      }

      if (textLength > 110) {
        pitchCounter.style.color = "red";
      } else {
        pitchCounter.style.color = "black";
      }

      pitchCounter.innerText = `${140 - textLength}`;

    });
  }
})()
