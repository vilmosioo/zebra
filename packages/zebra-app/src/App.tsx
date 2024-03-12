import * as React from "react";
import "./App.css";
import * as zip from "@zip.js/zip.js";
import { IGoal, IMood, IRawBullet, IRawMood } from "./finch";
import { CalendarHeatmap } from "./CalendarHeatmap";
import { Select } from "@blueprintjs/select";
import { CalendarTypeSelect } from "./CalendarTypeSelect";

function App() {
  const [moods, setMoods] = React.useState<IMood[]>([]);
  const [goals, setGoals] = React.useState<IGoal[]>([]);
  const [selectedGoal, setSelectedGoal] = React.useState<string | null>(null);
  const onFileDrop = React.useCallback(async (event: React.DragEvent<HTMLDivElement>) => {
    event.preventDefault();
    event.stopPropagation();

    const { files } = event.dataTransfer;
    if (files.length === 1) {
      const file = files.item(0);
      if (file == null) {
        throw new Error("Please upload one zip file.");
      }
      if (file.type !== "application/x-zip-compressed") {
        throw new Error("Please upload one zip file.");
      }
      const zipReader = new zip.ZipReader(new zip.BlobReader(file));
      const moodWriter = new zip.TextWriter();
      const goalWriter = new zip.TextWriter();
      const contents = await zipReader.getEntries();
      
      const moodFile = contents.find(content => content.filename === "Mood.json");
      const mood = JSON.parse(await moodFile?.getData?.(moodWriter) ?? "{\"data\": []}")?.data as IRawMood[];
      setMoods(mood.map(m => ({
        date: new Date(m.updated_time),
        value: m.value,
      })));

      try {
        const goalFile = contents.find(content => content.filename === "Bullet.json");
        const goals = JSON.parse(await goalFile?.getData?.(goalWriter) ?? "{\"data\": []}")?.data as IRawBullet[];
        setGoals(goals.filter(g => g.bullet_type === 1).map(m => ({
          date: new Date(m.dt),
          name: m.text,
          isCompleted: m.completed_time != "",
          // should be 5 but it's not a nice color
          value: m.completed_time != "" ? "4" : "1"
        })));
      } catch(err) {
        console.error(err);
      }
      await zipReader.close();
    } else {
      throw new Error("Please only upload one zip file.");
    }
  }, []);
  const handleDragOver = React.useCallback((event: React.DragEvent<HTMLDivElement>) => {
    event.preventDefault();
    event.stopPropagation();
  }, []);
  const items = React.useMemo(() => {
    return goals.map(g => g.name).filter((a,b,c) => c.indexOf(a) === b);
  }, [goals]);
  const onGoalSelect = React.useCallback((item: string) => {
    setSelectedGoal(item);
  }, []);
  return (
    <div className="app" onDrop={onFileDrop} onDragOver={handleDragOver}
    >
      <header className="app-header">
        Zebra
        <CalendarTypeSelect items={items} selectedItem={selectedGoal} onSelect={onGoalSelect} />
      </header>
      <div>
        <CalendarHeatmap values={selectedGoal != null ? (goals.filter(g => g.name === selectedGoal)) : moods} />
      </div>
    </div>
  );
}

export default App;
