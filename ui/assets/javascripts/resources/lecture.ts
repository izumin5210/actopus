import {Period} from "./period";

export interface Lecture {
  id: number;
  name: string;
  grade: number;
  department: string;
  course: string;
  specialTarget: string;
  peroids: Array<Period>;
  lecturers: Array<string>;
  code: string;
}
