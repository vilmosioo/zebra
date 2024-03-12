export interface IMood {
  value: string;
  date: Date;
}

export interface IGoal {
  isCompleted: boolean;
  value: string;
  date: Date;
  name: string;
}
  
export enum MoodType {
    Feeling = "feeling",
    Motivation = "motivation",
    Satisfaction = "satisfaction",
  }
  
export interface IRawMood {
    dt: string;
    mood_type: MoodType;
    value: string;
    updated_time: string;
  };

export interface IRawBullet {
  text: string;
  bullet_type: number;
  dt: string;
  completed_time: string;       
}