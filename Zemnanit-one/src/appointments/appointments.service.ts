import { Injectable } from '@nestjs/common';
import { Appointment } from './interfaces/appointment.interface';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { CreateAppointmentDto } from './dto/create-appointment.dto';
import { getAppointmentsFilterDto } from './dto/filter-appointment.dto';

@Injectable()
export class AppointmentsService {
    constructor(@InjectModel('Appointment') private readonly appointmentModel: Model<Appointment>) {}

    async getAppointments(filterDto: getAppointmentsFilterDto): Promise<Appointment[]> {
        let options = {};
        const { appointments } = filterDto;
        console.log(appointments);
        if (appointments) {
            options = {
                status: status
            };
        }
        return await this.appointmentModel.find(options);
    }

    async getOne(id: string): Promise<Appointment> {
        return await this.appointmentModel.findOne({ _id: id });
    }

    async create(appointment: CreateAppointmentDto, path: string): Promise<Appointment> {
        const newAppointment = new this.appointmentModel(appointment);
        console.log(newAppointment);
        newAppointment.picturePath = path; // Adjust if picturePath is relevant for appointments
        return await newAppointment.save();
    }

    async delete(id: string): Promise<Appointment> {
        return await this.appointmentModel.findByIdAndDelete(id);
    }

    async update(id: string, appointment: Appointment): Promise<Appointment> {
        return await this.appointmentModel.findByIdAndUpdate(id, appointment, { new: true });
    }

    async deleteAll(): Promise<any> {
        return await this.appointmentModel.deleteMany({});
    }
}
