// user-data.service.ts
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { signupDto } from 'src/users/dto/signup.dto';
import { LoginDto } from 'src/users/dto/login.dto';
import { UpdateRoleDto } from 'src/users/dto/update-role.dto'; // Import the DTO
import { User } from './users-data.model';
import * as bcrypt from 'bcrypt';
import { NotFoundException } from '@nestjs/common';

@Injectable()
export class UserDataService {
  constructor(@InjectModel('user') private readonly userdataModel: Model<User>) {}

  async insertUser(signUpDto: signupDto) {
    const newUser = new this.userdataModel({ ...signUpDto, email: signUpDto.email.toLowerCase(), role: 'User' });
    await newUser.save();
    return newUser;
  }

  async delete_user(email: string): Promise<User | undefined> {
    return this.userdataModel.findOneAndDelete({ email: email.toLowerCase() });
  }

  

  async get_user(email: string): Promise<User | null> {
    return this.userdataModel.findOne({ email: email.toLowerCase() }).exec();
  }
  
  

  async get_all_users() {
    return this.userdataModel.find({});
  }

  async update_password(logindto: LoginDto): Promise<User | undefined> {
    const user = await this.get_user(logindto.email);
    if (user && await bcrypt.compare(logindto.password, user.password)) {
      const hashedPassword = await bcrypt.hash(logindto.newPassword, 10);
      return this.userdataModel.findOneAndUpdate({ email: logindto.email.toLowerCase() }, { password: hashedPassword }, { new: true });
    }
  }

  // Add method for updating user role
  async update_role(updateRoleDto: UpdateRoleDto): Promise<User | undefined> {
    // Check if the user exists
    const existingUser = await this.get_user(updateRoleDto.email);
    if (!existingUser) {
      throw new NotFoundException('User not found');
    }

    // Update the user's role
    return this.userdataModel.findOneAndUpdate(
      { email: updateRoleDto.email.toLowerCase() },
      { role: updateRoleDto.role },
      { new: true }
    );
  }

  async createDefaultAdmin(signUpDto: signupDto): Promise<User> {
    const defaultAdmin = await this.userdataModel.findOne({ email: 'admin@email.com' });
    if (!defaultAdmin) {
      const newAdmin = new this.userdataModel({ ...signUpDto, email: signUpDto.email.toLowerCase(), role: 'Admin' });
      await newAdmin.save();
      return newAdmin;
    }
  }
}








