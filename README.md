# Peblo AI Story Buddy & Quiz Component

A Flutter-based educational storytelling application built for the Peblo Mobile App Developer Internship Challenge.

## Features

* AI Buddy character
* Text-to-Speech (TTS) story narration
* Data-driven quiz rendered from JSON
* Automatic transition from story to quiz
* Wrong answer feedback with Sad Robot state
* Correct answer celebration with Happy Robot and Confetti
* Provider state management
* Responsive mobile UI
* Kid-friendly design and animations

## Tech Stack

* Flutter
* Dart
* Provider
* flutter_tts
* confetti

## Framework Choice

I chose Flutter because it enables fast cross-platform development, provides excellent UI customization, and offers smooth performance on mid-range Android devices.

## Project Structure

```text
lib/
├── constants/
├── models/
├── providers/
├── screens/
├── services/
└── widgets/
```

## Story Flow

1. User taps "Read Me A Story"
2. AI Buddy narrates the story using Text-to-Speech
3. After narration completes, quiz appears automatically
4. Wrong answer → Sad Robot + retry feedback
5. Correct answer → Happy Robot + Confetti celebration

## State Transition Management

The application uses Provider for state management.

Flow:

1. User taps "Read Me A Story"
2. State changes to Loading
3. TTS narration begins
4. TTS completion callback triggers
5. Quiz appears automatically
6. User receives feedback based on answer selection

## Data-Driven Quiz Design

The quiz is generated dynamically from a JSON object instead of hardcoded UI.

Example:

```json
{
  "question": "What colour was Pip the Robot's lost gear?",
  "options": ["Red", "Green", "Blue", "Yellow"],
  "answer": "Blue"
}
```

The QuizWidget renders options dynamically, allowing future questions with different option counts without code changes.

## Audio Loading & Error Handling

* Loading indicator displayed before narration begins
* TTS errors handled gracefully
* User can retry if narration fails
* Application avoids crashes during TTS failures

## Caching Approach

This implementation uses the device's native Text-to-Speech engine through flutter_tts.

If a remote TTS API such as ElevenLabs were used, audio files would be cached locally to reduce network requests and improve performance.

## Performance Optimizations

* Provider minimizes unnecessary widget rebuilds
* Lightweight image assets
* Efficient state management
* Optimized for mid-range Android devices (~3GB RAM)
* Smooth animations and transitions

## AI Usage & Judgment

AI assistance was used for:

* Flutter architecture guidance
* State management recommendations
* UI improvement suggestions

One suggestion that was modified:

* A hardcoded quiz implementation was initially considered.
* It was replaced with a JSON-driven quiz renderer to ensure scalability and satisfy the challenge requirements.

### Challenges Faced

* Synchronizing TTS completion with quiz appearance
* Managing UI state transitions cleanly

### Solution

Implemented TTS completion callbacks and Provider-based state management to ensure reliable transitions.

## Author

S. Perumal

M.Sc Computer Science

Nazareth College of Arts & Science, Chennai
