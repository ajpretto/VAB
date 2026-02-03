# Remotion + AI Video Ad Research Report

**Date:** January 26, 2026  
**Context:** Solo creator had success with simple 30-min Remotion ad. Quality dropped when scaling with Claude Code (research → source media → templates → batch).

---

## 🎯 Key Finding: Simplicity Wins

Your initial success with the simple 30-minute video wasn't accidental. The research confirms: **the "AI scaling" approach introduces failure modes that don't exist in focused, human-guided work.**

---

## 1. What Makes Remotion Videos Effective

### Pacing Guidelines
| Element | Duration | Notes |
|---------|----------|-------|
| Title/intro | 2-3 seconds (60-90 frames @ 30fps) | Hook immediately |
| Key message | 3-5 seconds per scene | One idea per scene |
| Transitions | 0.5-1 second | Don't overdo |
| CTA/outro | 2-3 seconds | Clear action |

### What Works
- **Spring physics** over linear interpolation (feels natural)
- **Frame-based thinking** — 30 frames = 1 second at 30fps
- **Sequence components** for timing control
- **AbsoluteFill** for full-frame layouts
- **Brand constants** in code (colors, fonts exported once)
- **Simple transitions** — fade, slide, scale. Avoid complex wipes.

### Animation Best Practices
```tsx
// Good: Spring for natural motion
const scale = spring({ frame: frame - 30, fps, config: { damping: 100 } });

// Good: Clamped interpolation
const opacity = interpolate(frame, [0, 30], [0, 1], { extrapolateRight: 'clamp' });
```

---

## 2. Common AI/Claude Failure Modes

### ❌ What Goes Wrong

| Failure Mode | Why It Happens | Solution |
|--------------|----------------|----------|
| **Overloading** | Asking AI to generate entire video at once | Build scene-by-scene, component-by-component |
| **Generic output** | No brand constraints provided | Always specify colors, fonts, design tone upfront |
| **Bad timing** | Using seconds instead of frames | Prompt with frame numbers: "fade in over frames 0-30" |
| **Missing Skills** | Claude doesn't know Remotion patterns | Install official Skills: `npx skills add remotion-dev/skills` |
| **One-shot prompts** | Expecting perfection on first try | Iterate: generate → preview → refine |
| **Complex prompts** | Asking for multiple animations at once | Request one element/animation at a time |
| **Asset hunting** | AI searching for/generating media | Provide ALL media assets upfront |

### The Scale Problem
> "When I tried to scale with Claude Code (research, source media, build templates, batch production), quality dropped significantly."

**This is the core issue.** Each step introduces compounding error:
- Research → AI might get wrong context
- Source media → Generic stock, mismatched style  
- Build templates → Overengineered, not battle-tested
- Batch production → Multiplies all errors

---

## 3. Minimal Viable Workflow

### The "30-Minute Success" Pattern (Recommended)

```
1. PREPARE (Human: 10 min)
   └── Gather: logo, colors, fonts, 3-5 key messages, 1-2 media clips

2. STRUCTURE (Human + AI: 5 min)  
   └── Write scene list with durations (not a full storyboard)
   └── Example: "Scene 1: Logo reveal (2s) → Scene 2: Problem statement (3s)..."

3. GENERATE (AI: 10 min)
   └── One prompt per scene or element
   └── Preview after each generation
   └── Commit working states to git

4. POLISH (Human: 5 min)
   └── Adjust timing constants
   └── Fix any off-brand elements
   └── Add music last (keeps iteration fast)

5. RENDER
   └── `npx remotion render [comp] out/video.mp4`
```

### Anti-Pattern: The "Full Automation" Trap
```
❌ DON'T: "Research competitors, find stock footage, build a template system, 
          generate 10 variations"

✅ DO:    "Here's my logo, brand colors (#1a1a2e, #16213e), and font (Inter).
          Create a 5-second intro with the text 'TechFlow' fading in with spring 
          physics over frames 0-45."
```

---

## 4. Successful Remotion Examples (from X/Twitter)

### Official Sources
- **@Remotion** — Official account with examples
- **@JNYBGR** (Jonny Burger, creator) — Original Remotion trailer was pure React
- **Claude Code Community** posts Remotion demos regularly

### Notable Use Cases
- **GitHub Unwrapped** — Personalized year-in-review videos
- **Spotify Wrapped-style** — Data-driven personalization
- **Product demos** — Screen recordings with animated overlays
- **Captions/subtitles** — @remotion/captions with Whisper.cpp

### What Successful Ads Have in Common
1. **Simple, repeatable structure** (not overengineered)
2. **Human-provided assets** (not AI-sourced)
3. **Focused messaging** (one idea per scene)
4. **Consistent branding** (colors/fonts locked in code)

---

## 5. Client Asset Checklist

### Must Provide (Client)
| Asset | Format | Notes |
|-------|--------|-------|
| Logo | SVG preferred, PNG okay | Transparent background |
| Brand colors | Hex codes | Primary, secondary, background, text |
| Fonts | Google Font name or files | 1-2 fonts max |
| Key messages | Text list | 3-5 headlines/taglines |
| Media clips | MP4, MOV | Product shots, demos, etc. |
| Style reference | Link or screenshot | "Make it look like this" |

### Can Generate (AI/Developer)
- Text animations
- Background graphics (gradients, shapes)
- Transitions between scenes
- Timing/pacing adjustments
- Lower thirds, captions
- Basic motion graphics

### Should NOT Generate with AI
- Stock footage selection (quality varies wildly)
- Brand strategy/messaging
- Complex custom illustrations
- Music (use Suno or licensed tracks)

---

## 6. Actionable Recommendations

### For Your Workflow

1. **Lock in Remotion Skills immediately**
   ```bash
   npx skills add remotion-dev/skills
   ```

2. **Create a brand constants file** (use for every project)
   ```tsx
   // brand.ts
   export const COLORS = {
     primary: '#1E90FF',
     background: '#0F172A',
     text: '#FFFFFF',
   };
   export const FONTS = {
     heading: 'Inter, sans-serif',
     body: 'Inter, sans-serif',
   };
   ```

3. **Use the 80/20 prompt pattern**
   - 80% constraints (colors, fonts, dimensions, frame counts)
   - 20% creative request
   
   Example:
   > "Using brand colors #1E90FF and #0F172A, Inter font, 1920x1080 at 30fps: Create a title card where 'ProductName' fades in with spring physics from frames 0-45, centered on screen."

4. **Build a library of working scenes**
   - Title reveal
   - Feature highlight
   - CTA/outro
   - Transition
   
   Reuse these. Don't reinvent each time.

5. **Avoid the research/source/batch pipeline**
   - Get assets from client upfront
   - Generate one video at a time
   - Only batch after you have a proven template

### Quick Reference: Effective vs Ineffective Prompts

| ❌ Ineffective | ✅ Effective |
|----------------|--------------|
| "Make a cool product video" | "Create a 6-second intro with 'STARTUP' in bold white Inter, spring-scaling from 0.5 to 1.0 over frames 0-45, on #0f172a background" |
| "Add some transitions" | "Add a 15-frame fade transition between Scene1 and Scene2 using TransitionSeries" |
| "Make it look professional" | "Match this reference: [screenshot]. Use spring physics, 2s per scene, minimal motion" |

---

## Summary

**Your simple 30-minute approach worked because:**
- You provided clear constraints
- You built incrementally  
- Human judgment guided quality

**The scaled approach failed because:**
- AI compounding errors (research → source → build → batch)
- Too many unknowns in each step
- No human checkpoint between stages

**Recommended approach:** Keep the human in the loop for asset curation and quality checks. Let AI handle code generation for specific, well-constrained scenes. Build a small library of proven components. Batch only after validation.

---

## Resources

- [Remotion Skills](https://www.remotion.dev/docs/ai/skills)
- [Remotion + Claude Code Guide](https://www.remotion.dev/docs/ai/claude-code)
- [Remotion Templates](https://www.remotion.dev/templates/)
- [Timing Editor](https://www.remotion.dev/timing-editor)
- [FreeMotion](https://freemotion.dev) — Browser-based Remotion with auto-branding
