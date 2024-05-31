const error = document.getElementById('error')
const submit_button = document.getElementById('submit')
const full_name = document.getElementById('name')
const email = document.getElementById('email')
const age = document.getElementById('age')
const password = document.getElementById('password')
const confirm_pass = document.getElementById('confirmPass')



submit_button.addEventListener('click', function(e){
    let value = []

    e.preventDefault()

    if (!full_name.value){
        value.push('Please enter your full name')
    } 

    if (!age.value){
        value.push('Please enter your age')
    } 

    if (!email.value){
        value.push('Please enter your email')
    } 


  

    if (!password.value){
        value.push('Please enter your password')
    } 
    if (!confirm_pass.value){
        value.push('Please enter your password again')
    } 
    if (password.value){
    
        if (password.value.length < 8){
            value.push('length of password should be more than 8 characters')

        }
    }
    if (confirm_pass.value!=password.value){
        value.push('you have entered different passwords')
    }
    

    if (value.length > 0){

        if (value.length == 6){

      

           
            error.innerText = `Please fill all the required fields`
            error.style.display = 'block'
        }
        else{
          
          
            error.innerText = value[0]

            error.style.display = 'block'
        }
     }

     else{

       
           const result = fetch( "http://localhost:3000/users/signup", {
        method: 'post',
        headers: {
            'Accept': 'application/json, text/plain, */*',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify( {

            "email": email.value,
            "password": password.value,
            "fullname":full_name.value,
            "age":age.value,
            // "role":"user"

        } )
    } )
    .then( res => res.json() )
        .then( res => {

            
            if(res.msg === 'User successfully registered'){
            
            location.href = "login_page.html"
            }
            else{
            throw new Error('The user Already Exists')}
            
        } )
           .catch((error) => {
            error.innerText=`This Email has already been used`;
            error.style.display = "block";
          });





  
        

        
     }



})

