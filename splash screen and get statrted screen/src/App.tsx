import { useState, useEffect } from "react";
import Intro from "./imports/Intro";
import Welcome from "./imports/Welcome";
import Home from "./components/Home";

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<"intro" | "welcome" | "home">("intro");
  const [fadeOut, setFadeOut] = useState(false);

  // Auto-transition from Intro to Welcome after 3 seconds
  useEffect(() => {
    if (currentScreen === "intro") {
      const timer = setTimeout(() => {
        setFadeOut(true);
        setTimeout(() => {
          setCurrentScreen("welcome");
          setFadeOut(false);
        }, 500);
      }, 3000);
      return () => clearTimeout(timer);
    }
  }, [currentScreen]);

  const handleGetStarted = () => {
    setFadeOut(true);
    setTimeout(() => {
      setCurrentScreen("home");
      setFadeOut(false);
    }, 500);
  };

  return (
    <div className="size-full flex items-center justify-center bg-[#f5fafa]">
      {/* Mobile container */}
      <div className="relative w-full max-w-[414px] h-full max-h-[896px] bg-[#f5fafa] overflow-hidden shadow-2xl">
        <div
          className={`absolute inset-0 transition-opacity duration-500 ${
            fadeOut ? "opacity-0" : "opacity-100"
          }`}
        >
          {currentScreen === "intro" && <Intro />}
          {currentScreen === "welcome" && (
            <div className="relative size-full" onClick={handleGetStarted}>
              <Welcome />
            </div>
          )}
          {currentScreen === "home" && <Home />}
        </div>
      </div>
    </div>
  );
}
