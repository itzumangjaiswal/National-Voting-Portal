document.addEventListener('DOMContentLoaded', function() {

    console.log("Dashboard js loaded")
    const buttons = document.querySelectorAll('.tab-button');
    const sections = document.querySelectorAll('.table-section');

    buttons.forEach(button => {
        button.addEventListener('click', function() {
            // Remove active class from all buttons and sections
            buttons.forEach(btn => btn.classList.remove('active'));
            sections.forEach(section => section.classList.remove('active'));

            // Add active class to the clicked button and the respective section
            button.classList.add('active');
            const sectionToShow = document.getElementById(button.getAttribute('data-section'));
            sectionToShow.classList.add('active');
        });
    });
});
