
let del = body.querySelectorAll('.delete-btn')
let update = body.querySelectorAll('.update-btn')
async function display(){
    let html=``
     await fetch("http://localhost:3000/appointments")
      .then(res=>res.json())
      .then(data=>{
          data.forEach(element => {
              html+=`
              
          <div class="bg-white" style="display:grid; margin-top: 20px; margin-left: 40px; margin-right:40px; box-shadow: 0 0 5px black; width:80%; padding:10px; shadow: 0 0 15px red; ">
            <div class="flex flex-col">
              <div style ="font-size:25px; color: black;"><input form="form${element._id}"" class='input' type="text" name='name' required disabled value="${element.fullName}"></div>
              <div style ="font-size:25px; color: black;"><input form="form${element._id}"" class='input' type="text" name="location" required disabled value="${element.email}"></div>
              <div style ="font-size:25px; color: black;"><input form="form${element._id}" class='input' type="text" name="location" required disabled value="${element.hairStyle}"></div>
              <div style ="font-size:25px; color: black;"><input form="form${element._id}" class='input' type="text" name="location" required disabled value="${element.date}"></div>
              <div style ="font-size:25px; color: black;"><input form="form${element._id}" class='input' type="text" name="location" required disabled value="${element.time}"></div>
              </div>
              <div class="flex justify-center m-5">
              <div scope="row" ><button style = "padding: 5px; color:white; font-size:25px;  border-radius:8px" class="update-btn bg-peach">Edit Booking</button></div>
              <div scope="row" id="${element._id}"><button style = " padding: 5px; margin-left: 9px; font-size:25px; border-radius:8px" class="delete-btn bg-salmon">Cancel Booking</button></div>
            </div>
          </div>
          
          `  
          });
          
      })
      let body=document.getElementById('body')
      if (body){
        body.innerHTML=html
      }
      
      
      let del = body.querySelectorAll('.delete-btn')
      let update = body.querySelectorAll('.update-btn')
      
      
    if (del){
      del.forEach(btn=>{
      btn.addEventListener('click',deleteRow)
       
      } )
    }
    if (update){
      update.forEach(btn=>{
      btn.addEventListener('click',updateRow)
       
      } )
    }
}
display()
function updateRow(){

    let tableData=this.parentElement.parentElement.querySelectorAll('.input')
    const id =this.parentElement.parentElement.childNodes[1].id
    tableData.forEach(element=>{
        element.disabled=false
    })
    this.parentElement.innerHTML=`<button style = "background-color: aqua; padding: 5px; color:white; font-size:25px;  border-radius:8px" type='submit' form="form${id}" class="save-btn">save</button>`
   
    let save = body.querySelectorAll('.save-btn')
    if (save){
        save.forEach(btn=>{

        btn.addEventListener('click',saveRow)
        
        } )
}

}
function doThis(){

}
async function saveRow(e){
    e.preventDefault()
    const form=this.parentElement.parentElement.querySelector('form')

    const id =this.parentElement.parentElement.childNodes[1].id

    const formData= new FormData(form)

    let data={}
    for (let [key,val] of formData){

        data[key]=val
    }
   
    


    await fetch(`http://localhost:3000/appointments/${id}`,{
        method:'PATCH',
        body:JSON.stringify(data),
        headers: {
        'Content-Type': 'application/json'
        }

    })
    .then(res=>res.json())
    .then(data=>{

        let tableData=this.parentElement.parentElement.querySelectorAll('.input')
        let dataValue=[]
        for (let key in data){
            dataValue.push(data[key])
        }
        let i=1
        for (; i< dataValue.length-2;i++){
            tableData[i-1].value=dataValue[i]

        }
        this.parentElement.parentElement.querySelector('a').href=dataValue[i]
        tableData.forEach(element=>{
            element.disabled=true
        })
    
    })
    .catch(err=>console.log(err))

    this.parentElement.innerHTML=`<button style = "background-color: #2E8BC0; padding: 5px; color:white; font-size:25px;  border-radius:8px" class="update-btn" class="update-btn">update</button>`

    let update = body.querySelectorAll('.update-btn')
    if (update){
        update.forEach(btn=>{
        btn.addEventListener('click',updateRow)
        
        } )
    }

}
async function deleteRow(){
const id =this.parentElement.id
await fetch(`http://localhost:3000/appointments/${id}`,{method:'DELETE'})
.then(res=>res.json())
display()

}
const Salon= document.getElementById('form')
Salon.addEventListener('submit',addSalon)
 



async function addSalon(e){
    e.preventDefault()
    const formData=new FormData(Salon)
    let responseFetch;
   try{
        responseFetch=await fetch("http://localhost:3000/appointments",{
           method:'POST',
           body: formData
      
       })
   
   }catch(e){
       document.querySelector('error').innerHTML=error.message
   }
   if (responseFetch?.ok){
       responseFetch
       .then(res=> res.json())
       .then(data=>console.log("success",data))
   
   }else{
       if (responseFetch?.status==400){
           document.querySelector('.error').textContent=`allowed files are png, jpeg jpg or gif`
       }
   }
   
   }