export interface IMood {
  value: string;
  date: Date;
}

export interface IGoal {
  isCompleted: boolean;
  date: Date;
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
  date: string;
  completed_time: string;       
}