const btnToggle = document.querySelector('.btn_toggle');

// const btn = btnToggle[0];
btnToggle.addEventListener('click', ()=>{

    const body = document.body;
    body.classList.toggle('dark');
    if(body.classList.contains('dark')) {
        btnToggle.innerText = 'Light';
    } else {
        btnToggle.innerText = 'Dark';
    }
});
