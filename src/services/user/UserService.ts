import prismaClient from "../../prisma";

import { hash, compare } from "bcryptjs";

import { sign } from "jsonwebtoken";

interface CreateUserReq {
  name: string;
  email: string;
  password: string;
  profile: string;
}

interface AuthUserReq {
  email: string;
  password: string;
}

class UserService {
  // create user
  async createUserServ({ name, email, password, profile }: CreateUserReq) {
    if (!email) {
      throw new Error("Email is incorrect.");
    }

    const existEmail = await prismaClient.user.findFirst({
      where: {
        email: email,
      },
    });

    if (existEmail) {
      throw new Error("Email is already in the database.");
    }

    const passwordHash = await hash(password, 8);

    const user = await prismaClient.user.create({
      data: {
        name: name,
        email: email,
        password: passwordHash,
        profile: profile,
      },
      select: {
        id: true,
        name: true,
        email: true,
        profile: true,
      },
    });

    return user;
  }

  // auth user
  async authUserServ({ email, password }: AuthUserReq) {
    const existEmail = await prismaClient.user.findFirst({
      where: {
        email: email,
      },
    });

    if (!existEmail) {
      throw new Error("Email is incorrect.");
    }

    const passwordMatch = await compare(password, existEmail.password);
    if (!passwordMatch) {
      throw new Error("Password is incorrent.");
    }

    return { user: "authUserServ" };
  }

  // update user
  // delete user
  // read all users
  // read by ? user
}

export { UserService };
