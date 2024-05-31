import { IsIn, IsNotEmpty, IsOptional } from "class-validator";
import { appointments } from "../appointments.enum";

export class getAppointmentsFilterDto{

    @IsOptional()
    @IsIn([appointments.Esat,appointments.kurt])
appointments:appointments

  
}