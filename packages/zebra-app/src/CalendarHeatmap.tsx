import * as React from "react";
import OriginalCalendarHeatmap, { ReactCalendarHeatmapValue } from "react-calendar-heatmap";
import { IMood } from "./finch";
import styles from "./CalendarHeatmap.module.css";

interface IHeatMapProps {
    values: IMood[];
}

// eslint-disable-next-line no-console
console.log(styles);

export const CalendarHeatmap = function({ values }: IHeatMapProps) {
  const classForValue = React.useCallback((value: ReactCalendarHeatmapValue<Date> | undefined) => {
    switch(value?.value) {
    case "1":
      return styles["color-github-0"];
    case "2":
      return styles["color-github-1"];
    case "3":
      return styles["color-github-2"];
    case "4":
      return styles["color-github-3"];
    case "5":
      return styles["color-github-4"];
    default:
      // class from react-calendar-heatmap
      return "color-empty";
    }
  }, []);
  return <OriginalCalendarHeatmap values={values} classForValue={classForValue} />;
};
