export class CreateAppointmentDto {
    readonly name: string;
    readonly picturePath: string;  // If this property is relevant for appointments
    readonly location: string;     // If this property is relevant for appointments
    // Add other appointment-specific properties here
}
