import { Request, Response, Router } from "express";
import { UserController } from "./controllers/user/UserController";

const router = Router();

router.post("/create-user", new UserController().createUserCtr);
router.post("/auth-user", new UserController().authUserCtr);
export { router };
