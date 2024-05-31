import { Controller, Get,Post,Put, Delete,Param,Body, UseInterceptors, BadRequestException, UploadedFile, Res, Patch, Query, ValidationPipe, UseGuards} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { CreateSalonDto} from './dto/create-salon.dto';
import { SalonsService } from './salons.service';
import { Salon } from './interfaces/salon.interface';
import { diskStorage } from 'multer';
import { Response } from 'express';
import { getSalonFilterDto } from './dto/filter-salon.dto';
import { Roles } from 'src/users/roles.decorators';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { Role } from 'src/users/enums/role.enum';



@Controller('salons')
export class SalonsController {
    constructor(private readonly salonService:SalonsService){}
    
    @Get()
    getHotels(@Query(ValidationPipe) filterDto:getSalonFilterDto):Promise<Salon[]>{
        console.log(filterDto)
        return this.salonService.getSalona(filterDto)

    }
    @Get(':id')
    getOne(@Param('id') id):Promise<Salon>{
        return this.salonService.getOne(id);

    }
    @Patch(':id')
    update(@Body() updateSalonDto:CreateSalonDto,@Param('id') id):Promise<Salon>{
        return this.salonService.update(id,updateSalonDto)
    }

    @Delete(':id')
    delete(@Param('id') id):Promise<Salon>{
        return this.salonService.delete(id)
    }
    @Delete()
    deleteAll():Promise<any>{
        return this.salonService.deleteAll()
    }
    
    @UseGuards(JwtAuthGuard)
    @Roles(Role.Admin)
    @Post()
    @UseInterceptors(FileInterceptor('file', {
        storage: diskStorage({
            destination:"./uploads",
            filename:(req,file,cb) => {
                const name = file.originalname.split('.')[0]
                const fileExtension = file.originalname.split('.')[1]
                const newFileName = name.split(' ').join('_') + '_' + Date.now() + '.' + fileExtension

                cb(null, newFileName)
            }
        }),
        fileFilter: (req,file,cb)=>{
            if(!file.originalname.match(/\.(jpeg|jpg|png|gif)$/)){
                return cb(null,false)

            }
            cb(null,true)

        }
    }))

    uploadData( @Body() hotelDTO:CreateSalonDto,@UploadedFile('file') file:Express.Multer.File){
        if (!file){
            throw new BadRequestException("File is not appropriates.")
        } else {

            const filePathURL = `http://localhost:3000/salons/viewImage/${file.filename}`
            this.salonService.create(hotelDTO,filePathURL)
        }
    }
    @Get('viewImage/:filename')
    async viewTheFile(@Param('filename') filename, @Res() res:Response): Promise<void> {
        return await res.sendFile(filename,{root: './uploads'})
    } 

    

}
