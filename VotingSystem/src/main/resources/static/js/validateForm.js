export async function validateForm(formData){

    for (const [key, value] of formData.entries()) {
        console.log(`${key} : ${value}`)
        if(value === "" || value==='drop-down-default'){
            const properKeyName = getProperFieldName(key)
            alert(`${properKeyName} cannot be empty`)
            throw new Error("Empty Field not permitted")
        }
    }

}

function getProperFieldName(key){
    return key
        .replace(/_/g, ' ') // Replace underscores with spaces
        .split(' ') // Split the sentence into words
        .map(word => word.charAt(0).toUpperCase() + word.slice(1)) // Capitalize the first letter of each word
        .join(' '); // Join the words back into a single string
}