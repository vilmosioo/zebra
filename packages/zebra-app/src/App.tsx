import React from "react";
import "./App.css";
import CalendarHeatmap from "react-calendar-heatmap";

function App() {
  const values = [{
    date: new Date(),
    value: 1
  }];
  return (
    <div className="app">
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
