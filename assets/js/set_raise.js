(() => {
  const salaryMin = document.querySelector("input#candidate_salary_min"),
        salaryMax = document.querySelector("input#candidate_salary_max"),
        raiseAmount = document.querySelector("input#candidate_desired_raise");

  if (salaryMin && salaryMax && raiseAmount) {
    [salaryMin, salaryMax].map(input => {
      input.addEventListener("change", () => {
        if (salaryMin.value !== "" && salaryMax.value !== "" && raiseAmount.value === "") {
          const suggestedRaise = (parseInt(salaryMin.value) + parseInt(salaryMax.value)) / 24;
          raiseAmount.value = Math.floor(suggestedRaise);
        }
      })
    })
  }
})();
