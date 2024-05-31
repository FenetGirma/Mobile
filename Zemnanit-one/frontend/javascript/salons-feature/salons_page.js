
async function display(){
    let html=``
     await fetch("http://localhost:3000/salons")
      .then(res=>res.json())
      .then(data=>{
          data.forEach(element => {
              html+=`
              
          <div style="display:flex; flex-direction: column; justify-content:center; align-items:center;">
          <div class="bg-white m-5 p-3 flex flex-col justify-center">
          <div><img width="220rem" height="220rem" src= "${element.picturePath}"></div>

              <div style ="font-size:25px; color: brown; shadow: 0 0 15px red;"><form id="form${element._id}"><input class='input' type="text" name='name' required disabled value="${element.name}"></form></div>
              <div style ="font-size:25px; color: black;" class="flex"><svg width="16" viewBox="-4 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:sketch="http://www.bohemiancoding.com/sketch/ns" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <title>location</title> <desc>Created with Sketch Beta.</desc> <defs> </defs> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" sketch:type="MSPage"> <g id="Icon-Set-Filled" sketch:type="MSLayerGroup" transform="translate(-106.000000, -413.000000)" fill="#CE4E4E"> <path d="M118,422 C116.343,422 115,423.343 115,425 C115,426.657 116.343,428 118,428 C119.657,428 121,426.657 121,425 C121,423.343 119.657,422 118,422 L118,422 Z M118,430 C115.239,430 113,427.762 113,425 C113,422.238 115.239,420 118,420 C120.761,420 123,422.238 123,425 C123,427.762 120.761,430 118,430 L118,430 Z M118,413 C111.373,413 106,418.373 106,425 C106,430.018 116.005,445.011 118,445 C119.964,445.011 130,429.95 130,425 C130,418.373 124.627,413 118,413 L118,413 Z" id="location" sketch:type="MSShapeGroup"> </path> </g> </g> </g></svg>
              <input form="form${element._id}" class='input' type="text" name="location" required disabled value="${element.location}"></div>
              <div scope="row" ><button onclick="redirect()" style = " padding: 5px; color:white; font-size:25px;  border-radius:8px; margin:40px" class="book-btn bg-peach">Book Here</button></div>
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
   
    


    await fetch(`http://localhost:3000/salons/${id}`,{
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
await fetch(`http://localhost:3000/salons/${id}`,{method:'DELETE'})
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
        responseFetch=await fetch("http://localhost:3000/salons",{
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
   
function redirect(){
    window.location.href = 'book.html';
  }