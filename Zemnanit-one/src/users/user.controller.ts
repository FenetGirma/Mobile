import { Body, Controller, Post, Get, UseGuards, Request, Delete,Patch, Param, HttpException, HttpStatus } from '@nestjs/common';
import { UsersService } from './users.service';
import * as bcrypt from 'bcrypt';
import { Roles } from './roles.decorators';
import { LocalAuthGuard } from 'src/auth/guards/local-auth.guard';
import { RolesGuard } from 'src/auth/guards/roles.guard';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { AuthService } from 'src/auth/auth.service';
import { Role } from './enums/role.enum';
import { signupDto } from './dto/signup.dto';
import { Sign } from 'crypto';
import { LoginDto } from './dto/login.dto';
import { UpdateRoleDto } from './dto/update-role.dto';



@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService, private readonly authService: AuthService) {}
  
  // signup
  @Post('signup')
      async addUser(
    @Body() signUpDto:signupDto
      ) {

        const saltOrRounds = 10;
        const hashedPassword = await bcrypt.hash(signUpDto.password, saltOrRounds);
        signUpDto.password = hashedPassword
        
        const result = await this.usersService.insertUser(
          signUpDto
        );
      
        return {
          msg: 'User successfully registered',
          userId: result.id,
          userName: result.email
        };

      }


      //login

  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Request() req) {
    try {
      return this.authService.login(req.user);
    } catch (error) {
      throw new HttpException({
        status: HttpStatus.UNAUTHORIZED,
        error: 'Invalid credentials. Please try again.',
      }, HttpStatus.UNAUTHORIZED);
    }
  }


  
  @UseGuards(JwtAuthGuard,RolesGuard)
  @Get(':email')
  get_user(@Param('email') email:string){
    return this.usersService.get_user(email);
}

  


  
  @Delete(':email')
  delete_user(@Param('email') email:string){
       return this.usersService.delete_user(email);
  }




  @UseGuards(JwtAuthGuard)
  @Roles(Role.Admin)
  @Get()
   getallusers(){
    return this.usersService.get_all_users();
   }  

   @UseGuards(JwtAuthGuard)
   @Get('salons')
   gethotel(){
    return {"sign":"is_singed_in"};
   }  
  
  @Patch()
  async update_password(@Body() pass:LoginDto){
    return this.usersService.update_password(pass);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Patch('update-role')
  async update_role(@Body() updateRoleDto: UpdateRoleDto) {
    return this.usersService.update_role(updateRoleDto);
  }

      

  
}