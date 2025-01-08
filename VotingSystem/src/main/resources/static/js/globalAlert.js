export function showAlert(alertType, alertMessage){

    const width = window.innerWidth
    const height = window.innerHeight
    console.log("w " + width)
    console.log("h " + height)

    const alertBox = document.createElement('div')
    alertBox.classList.add('alert-box')

    const closeButton = document.createElement('button')
    closeButton.innerHTML = '&times;'
    closeButton.classList.add('close-btn')

    let message = ""
    if(alertType === 'success') {
        message = '<strong>Success!</strong> ' +  alertMessage
        alertBox.id='successAlert'
        alertBox.classList.add('success')

        closeButton.addEventListener('click',()=>{
            document.getElementById('successAlert').style.display='none'
        })
    }

    else if(alertType === 'failed') {
        message = '<strong>Failed!</strong> ' +  alertMessage
        alertBox.id='failedAlert'
        alertBox.classList.add('failed')

        closeButton.addEventListener('click',()=>{
            document.getElementById('failedAlert').style.display='none'
        })
    }

    const paragraph = document.createElement('p')
    paragraph.innerHTML = message



    alertBox.appendChild(closeButton)
    alertBox.appendChild(paragraph)


    const alertDiv = document.getElementById('alert')
    alertDiv.appendChild(alertBox)
    alertDiv.style.position ='absolute';
    alertDiv.style.top = `${height*0.18}px`
    alertDiv.style.left = `${width * 0.725}px`
    alertDiv.style.width = `${width * 0.31}px`
    alertDiv.style.zIndex = '1000'

}