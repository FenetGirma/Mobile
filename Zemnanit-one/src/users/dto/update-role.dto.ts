import { IsEmail, IsEnum, IsNotEmpty } from '@nestjs/class-validator';
import { Role } from '../enums/role.enum';

export class UpdateRoleDto {
  @IsEmail()
  @IsNotEmpty()
  public email: string;

  @IsEnum(Role)
  @IsNotEmpty()
  public role: Role;
}
