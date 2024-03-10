export interface IMood {
    value: string;
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