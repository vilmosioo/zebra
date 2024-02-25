import React from "react";
import { render, screen } from "@testing-library/react";
import App from "./App";

test("renders zebra title", () => {
  render(<App />);
  const linkElement = screen.getByText(/zebra/i);
  expect(linkElement).toBeInTheDocument();
});
