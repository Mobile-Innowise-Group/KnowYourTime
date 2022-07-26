abstract class TrackerBoardEvent {
  const TrackerBoardEvent();
}

class PressDailyButton implements TrackerBoardEvent {
  const PressDailyButton();
}

class PressWeeklyButton implements TrackerBoardEvent {
  const PressWeeklyButton();
}

class PressMonthlyButton implements TrackerBoardEvent {
  const PressMonthlyButton();
}

class LoadTimeFrames implements TrackerBoardEvent {
  const LoadTimeFrames();
} 
