import * as React from "react";
import "./App.css";
import CalendarHeatmap, { ReactCalendarHeatmapValue } from "react-calendar-heatmap";
import * as zip from "@zip.js/zip.js";

interface IMood {
  value: string;
  date: Date;
}

enum MoodType {
  Feeling = "feeling",
  Motivation = "motivation",
  Satisfaction = "satisfaction",
}

interface IRawMood {
  dt: string;
  mood_type: MoodType;
  value: string;
  updated_time: string;
};

function App() {
  const [values, setValues] = React.useState<IMood[]>([]);
  const onFileDrop = React.useCallback(async (event: React.DragEvent<HTMLDivElement>) => {
    event.preventDefault();
    event.stopPropagation();
    console.log(event);

    const { files } = event.dataTransfer;
    if (files.length === 1) {
      const file = files.item(0);
      if (file == null) {
        throw new Error("Please upload one zip file.");
      }
      if (file.type !== "application/x-zip-compressed") {
        throw new Error("Please upload one zip file.");
      }
      console.log(file);
      const zipReader = new zip.ZipReader(new zip.BlobReader(file));
      const helloWorldWriter = new zip.TextWriter();
      const contents = await zipReader.getEntries();
      const moodFile = contents.find(content => content.filename === "Mood.json");
      const mood = JSON.parse(await moodFile?.getData?.(helloWorldWriter) ?? "{\"data\": []}")?.data as IRawMood[];
      setValues(mood.map(m => ({
        date: new Date(m.updated_time),
        value: m.value,
      })));
      console.log(mood);
      await zipReader.close();
    } else {
      throw new Error("Please only upload one zip file.");
    }
  }, []);
  const handleDragOver = React.useCallback((event: React.DragEvent<HTMLDivElement>) => {
    event.preventDefault();
    event.stopPropagation();
  }, []);
  const classForValue = React.useCallback((value: ReactCalendarHeatmapValue<Date> | undefined) => {
    switch(value?.value) {
    case "1":
      return "color-github-0";
    case "2":
      return "color-github-1";
    case "3":
      return "color-github-2";
    case "4":
      return "color-github-3";
    case "5":
      return "color-github-4";
    default:
      return "color-empty";
    }
  }, []);
  return (
    <div className="app" onDrop={onFileDrop} onDragOver={handleDragOver}
    >
      <header className="app-header">
        Zebra
      </header>
      <div>
        <CalendarHeatmap values={values} classForValue={classForValue} />
      </div>
    </div>
  );
}

export default App;
