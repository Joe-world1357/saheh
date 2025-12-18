import { Activity, Heart, Apple, Dumbbell, Calendar, User, Home as HomeIcon, TrendingUp } from "lucide-react";
import { Card } from "./ui/card";
import { Button } from "./ui/button";

export default function Home() {
  const stats = [
    { icon: Activity, label: "Steps", value: "8,432", goal: "10,000", color: "#20C6B7" },
    { icon: Heart, label: "Heart Rate", value: "72 bpm", subtext: "Normal", color: "#FF6B9D" },
    { icon: Apple, label: "Calories", value: "1,842", goal: "2,000", color: "#FFA726" },
    { icon: Dumbbell, label: "Workout", value: "45 min", subtext: "Today", color: "#9C27B0" },
  ];

  const quickActions = [
    { icon: Activity, label: "Log Activity", color: "#20C6B7" },
    { icon: Calendar, label: "Schedule", color: "#42A5F5" },
    { icon: Apple, label: "Nutrition", color: "#FFA726" },
    { icon: TrendingUp, label: "Progress", color: "#66BB6A" },
  ];

  return (
    <div className="bg-[#f5fafa] size-full overflow-auto">
      {/* Header */}
      <div className="bg-gradient-to-br from-[#20C6B7] to-[#1A9A8E] px-6 pt-12 pb-8 rounded-b-[32px]">
        <div className="flex items-center justify-between mb-8">
          <div>
            <p className="text-white/80 mb-1">Welcome back,</p>
            <h1 className="text-white">Sarah</h1>
          </div>
          <div className="size-12 bg-white/20 rounded-full flex items-center justify-center">
            <User className="size-6 text-white" />
          </div>
        </div>
        
        {/* Daily Goal Card */}
        <Card className="bg-white/95 backdrop-blur p-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-muted-foreground">Daily Goal Progress</span>
            <span className="text-[#20C6B7]">84%</span>
          </div>
          <div className="h-2 bg-gray-100 rounded-full overflow-hidden">
            <div className="h-full bg-gradient-to-r from-[#20C6B7] to-[#1A9A8E] w-[84%] rounded-full" />
          </div>
        </Card>
      </div>

      {/* Stats Grid */}
      <div className="px-6 py-6">
        <h2 className="mb-4">Today's Stats</h2>
        <div className="grid grid-cols-2 gap-4 mb-6">
          {stats.map((stat, index) => (
            <Card key={index} className="p-4 hover:shadow-lg transition-shadow">
              <div className="flex items-start justify-between mb-3">
                <div
                  className="size-10 rounded-xl flex items-center justify-center"
                  style={{ backgroundColor: `${stat.color}15` }}
                >
                  <stat.icon className="size-5" style={{ color: stat.color }} />
                </div>
              </div>
              <p className="text-sm text-muted-foreground mb-1">{stat.label}</p>
              <p className="text-2xl mb-1">{stat.value}</p>
              {stat.goal && (
                <p className="text-xs text-muted-foreground">Goal: {stat.goal}</p>
              )}
              {stat.subtext && (
                <p className="text-xs" style={{ color: stat.color }}>{stat.subtext}</p>
              )}
            </Card>
          ))}
        </div>

        {/* Quick Actions */}
        <h3 className="mb-4">Quick Actions</h3>
        <div className="grid grid-cols-4 gap-3 mb-6">
          {quickActions.map((action, index) => (
            <button
              key={index}
              className="flex flex-col items-center gap-2 p-3 rounded-2xl hover:bg-white transition-colors"
            >
              <div
                className="size-12 rounded-xl flex items-center justify-center"
                style={{ backgroundColor: `${action.color}15` }}
              >
                <action.icon className="size-5" style={{ color: action.color }} />
              </div>
              <span className="text-xs text-center">{action.label}</span>
            </button>
          ))}
        </div>

        {/* Recent Activity */}
        <h3 className="mb-4">Recent Activity</h3>
        <Card className="p-4 mb-4">
          <div className="flex items-center gap-3">
            <div className="size-12 bg-[#20C6B715] rounded-xl flex items-center justify-center">
              <Dumbbell className="size-6 text-[#20C6B7]" />
            </div>
            <div className="flex-1">
              <p>Morning Yoga</p>
              <p className="text-sm text-muted-foreground">30 minutes • 2 hours ago</p>
            </div>
            <div className="text-right">
              <p className="text-[#20C6B7]">+150</p>
              <p className="text-xs text-muted-foreground">calories</p>
            </div>
          </div>
        </Card>

        <Card className="p-4 mb-4">
          <div className="flex items-center gap-3">
            <div className="size-12 bg-[#FFA71615] rounded-xl flex items-center justify-center">
              <Apple className="size-6 text-[#FFA726]" />
            </div>
            <div className="flex-1">
              <p>Breakfast Logged</p>
              <p className="text-sm text-muted-foreground">Oatmeal & Fruits • 3 hours ago</p>
            </div>
            <div className="text-right">
              <p className="text-[#FFA726]">420</p>
              <p className="text-xs text-muted-foreground">calories</p>
            </div>
          </div>
        </Card>
      </div>

      {/* Bottom Navigation */}
      <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-border px-6 py-4 max-w-[414px] mx-auto">
        <div className="flex items-center justify-around">
          <Button variant="ghost" size="sm" className="flex flex-col items-center gap-1 h-auto py-2">
            <HomeIcon className="size-5 text-[#20C6B7]" />
            <span className="text-xs text-[#20C6B7]">Home</span>
          </Button>
          <Button variant="ghost" size="sm" className="flex flex-col items-center gap-1 h-auto py-2">
            <Activity className="size-5 text-muted-foreground" />
            <span className="text-xs text-muted-foreground">Activity</span>
          </Button>
          <Button variant="ghost" size="sm" className="flex flex-col items-center gap-1 h-auto py-2">
            <TrendingUp className="size-5 text-muted-foreground" />
            <span className="text-xs text-muted-foreground">Progress</span>
          </Button>
          <Button variant="ghost" size="sm" className="flex flex-col items-center gap-1 h-auto py-2">
            <User className="size-5 text-muted-foreground" />
            <span className="text-xs text-muted-foreground">Profile</span>
          </Button>
        </div>
      </div>
    </div>
  );
}
