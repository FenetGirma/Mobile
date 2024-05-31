import { Module } from '@nestjs/common';
import {MongooseModule} from '@nestjs/mongoose';
import { AppointmentsController } from './appointments.controller';
import {AppointmentsService } from './appointments.service';
import { AppointmentSchema } from './schema/appointments.schema';
@Module({
    imports:[MongooseModule.forFeature([{name:'Appointment',schema:AppointmentSchema}])],
    controllers:[AppointmentsController],
    providers:[AppointmentsService]
})
export class AppointmentsModule {}
