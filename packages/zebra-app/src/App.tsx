import * as React from "react";
import "./App.css";
import * as zip from "@zip.js/zip.js";
import { IMood, IRawMood } from "./finch";
import { CalendarHeatmap } from "./CalendarHeatmap";

function App() {
  const [values, setValues] = React.useState<IMood[]>([]);
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
      const helloWorldWriter = new zip.TextWriter();
      const contents = await zipReader.getEntries();
      const moodFile = contents.find(content => content.filename === "Mood.json");
      const mood = JSON.parse(await moodFile?.getData?.(helloWorldWriter) ?? "{\"data\": []}")?.data as IRawMood[];
      setValues(mood.map(m => ({
        date: new Date(m.updated_time),
        value: m.value,
      })));
      await zipReader.close();
    } else {
      throw new Error("Please only upload one zip file.");
    }
  }, []);
  const handleDragOver = React.useCallback((event: React.DragEvent<HTMLDivElement>) => {
    event.preventDefault();
    event.stopPropagation();
  }, []);
  return (
    <div className="app" onDrop={onFileDrop} onDragOver={handleDragOver}
    >
      <header className="app-header">
        Zebra
      </header>
      <div>
        <CalendarHeatmap values={values} />
      </div>
    </div>
  );
}

export default App;
