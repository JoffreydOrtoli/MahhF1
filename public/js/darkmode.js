const btnToggle = document.querySelector('.btn_toggle');

btnToggle.addEventListener('click', ()=>{

    const body = document.body;
    body.classList.toggle('dark');
    if(body.classList.contains('dark')) {
        btnToggle.innerText = 'Light';
    } else {
        btnToggle.innerText = 'Dark';
    }
    if (body.classList.contains('dark')) {
        localStorage.setItem('darkMode', 'enabled');
    } else {
        localStorage.setItem('darkMode', 'disabled');
    }
});

if(localStorage.getItem('darkMode') === 'enabled') {
    document.body.classList.toggle('dark');
}