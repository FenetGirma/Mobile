import * as mongoose from 'mongoose';

export const AppointmentSchema = new mongoose.Schema({
    comment: {
        type: String,
        required: [true, 'An appointment must have a name'],  
        unique: true,   
        trim: true
    },
    picturePath: String, // Adjust if relevant to appointments
    date: {
        type: String,
        required: [true, 'An appointment must have a location']
    },
    time: {
        type:String,
        required: [true ,'provide the time']
    }

    // Add other fields relevant to appointments
});


