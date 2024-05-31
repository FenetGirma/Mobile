import { 
    Controller, 
    Get, 
    Post, 
    Put, 
    Delete, 
    Param, 
    Body, 
    UseInterceptors, 
    BadRequestException, 
    UploadedFile, 
    Res, 
    Patch, 
    Query, 
    ValidationPipe, 
    UseGuards 
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { CreateAppointmentDto } from './dto/create-appointment.dto';
import { AppointmentsService } from './appointments.service';
import { Appointment } from './interfaces/appointment.interface';
import { diskStorage } from 'multer';
import { Response } from 'express';
import { getAppointmentsFilterDto } from './dto/filter-appointment.dto';
import { Roles } from 'src/users/roles.decorators';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { Role } from 'src/users/enums/role.enum';

@Controller('appointments')
export class AppointmentsController {
    constructor(private readonly appointmentService: AppointmentsService) {}

    @Get()
    getAppointments(@Query(ValidationPipe) filterDto: getAppointmentsFilterDto): Promise<Appointment[]> {
        console.log(filterDto)
        return this.appointmentService.getAppointments(filterDto);
    }

    @Get(':id')
    getOne(@Param('id') id: string): Promise<Appointment> {
        return this.appointmentService.getOne(id);
    }

    @Patch(':id')
    update(@Body() updateAppointmentDto: CreateAppointmentDto, @Param('id') id: string): Promise<Appointment> {
        return this.appointmentService.update(id, updateAppointmentDto);
    }

    @Delete(':id')
    delete(@Param('id') id: string): Promise<Appointment> {
        return this.appointmentService.delete(id);
    }

    @Delete()
    deleteAll(): Promise<any> {
        return this.appointmentService.deleteAll();
    }

    @UseGuards(JwtAuthGuard)
    @Roles(Role.Admin)
    @Post()
    @UseInterceptors(FileInterceptor('file', {
        storage: diskStorage({
            destination: "./uploads",
            filename: (req, file, cb) => {
                const name = file.originalname.split('.')[0];
                const fileExtension = file.originalname.split('.')[1];
                const newFileName = name.split(' ').join('_') + '_' + Date.now() + '.' + fileExtension;

                cb(null, newFileName);
            }
        }),
        fileFilter: (req, file, cb) => {
            if (!file.originalname.match(/\.(jpeg|jpg|png|gif)$/)) {
                return cb(null, false);
            }
            cb(null, true);
        }
    }))
    uploadData(@Body() appointmentDTO: CreateAppointmentDto, @UploadedFile('file') file: Express.Multer.File) {
        if (!file) {
            throw new BadRequestException("File is not appropriate.");
        } else {
            const filePathURL = `http://localhost:3000/appointments/viewImage/${file.filename}`;
            this.appointmentService.create(appointmentDTO, filePathURL);
        }
    }

    @Get('viewImage/:filename')
    async viewTheFile(@Param('filename') filename: string, @Res() res: Response): Promise<void> {
        return await res.sendFile(filename, { root: './uploads' });
    }
}
