import { IsNotEmpty, IsString } from "@nestjs/class-validator";


export class signupDto{
      @IsString()
      @IsNotEmpty()
      public fullname: string;

      @IsString()
      @IsNotEmpty()
      public age: string;

      @IsString()
      @IsNotEmpty()
      public password: string;

      @IsString()
      @IsNotEmpty()
      public email: string;

      @IsString()
      public role: string;
}

