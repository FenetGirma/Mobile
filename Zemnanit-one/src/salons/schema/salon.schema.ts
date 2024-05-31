import * as mongoose from 'mongoose';
export const SalonSchema =new mongoose.Schema({
    name: {
            type: String,
            required: [true, 'A hotel must have a name'],  
            unique: true,   
            trim: true
        },
    picturePath:String,
    location:{
            type: String,
            required: [true, 'A hotel must have a location']}
   

})

