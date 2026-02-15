// fetch existing student data
let studentList = JSON.parse(localStorage.getItem("studentData")) || [];

document.getElementById("regForm").addEventListener("submit", function (e) {
    e.preventDefault();

    let student = {
        name: document.getElementById("name").value.trim(),
        email: document.getElementById("email").value.trim(),
        dob: document.getElementById("dob").value,
        dept: document.getElementById("department").value,
        phone: document.getElementById("phone").value.trim()
    };

    studentList.push(student);
    localStorage.setItem("studentData", JSON.stringify(studentList));

    alert("Student registered successfully!");
    this.reset();
});
