import { Request, Response } from "express";

import { UserService } from "../../services/user/UserService";

class UserController {
  // create user
  async createUserCtr(req: Request, res: Response) {
    const { name, email, password, profile } = req.body;
    const userService = new UserService();
    const user = await userService.createUserServ({
      name,
      email,
      password,
      profile,
    });
    return res.json(user);
  }

  // auth user
  async authUserCtr(req: Request, res: Response) {
    const { email, password } = req.body;
    const userService = new UserService();
    const auth = await userService.authUserServ({
      email,
      password,
    });

    return res.json(auth);
  }

  // update user
  // delete user
  // read all users
  // read by ? user
}

export { UserController };
