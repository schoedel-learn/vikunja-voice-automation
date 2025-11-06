# 🔧 Fix: Unknown parameter 'repeat_penalty' Error

**Problem:** Open WebUI showing error "Unknown parameter: 'repeat_penalty'" when using OpenAI models (GPT-4, GPT-4o, GPT-5)

**Cause:** `repeat_penalty` is a parameter for LOCAL models (Ollama, LLaMA) and is NOT supported by OpenAI's API.

**Fix Time:** 2 minutes

---

## Quick Fix (Web UI)

### Step 1: Navigate to Model Settings

1. Go to: https://ai.opshub.host/workspace/models/edit?id=educate-barry
2. Or: **Workspace** → **Models** → **Edit** (next to "educate-barry")

### Step 2: Find the Parameters Section

Scroll down to find the **"Parameters"** or **"Model Configuration"** section.

You'll see something like:

```json
{
  "temperature": 0.7,
  "top_p": 1.0,
  "repeat_penalty": 1.1,    ← DELETE THIS LINE
  "max_tokens": 4096
}
```

### Step 3: Delete `repeat_penalty`

**Remove this line:**
```
repeat_penalty: 1.1
```

### Step 4: Add OpenAI-Compatible Parameters

**Add these lines instead:**
```
frequency_penalty: 0.3
presence_penalty: 0.0
```

**Result should look like:**
```json
{
  "temperature": 0.7,
  "top_p": 1.0,
  "frequency_penalty": 0.3,
  "presence_penalty": 0.0,
  "max_tokens": 4096
}
```

### Step 5: Save & Test

1. Click **"Save"** at the bottom
2. Go back to your chat: https://ai.opshub.host/c/023512ee-4b66-4094-b498-62600ff80613
3. Try uploading your files again
4. It should work now! ✅

---

## What Changed?

| Parameter | Local Models | OpenAI Models | Purpose |
|-----------|--------------|---------------|---------|
| `repeat_penalty` | ✅ Supported | ❌ **NOT SUPPORTED** | Reduces word repetition |
| `frequency_penalty` | ❌ Not supported | ✅ **USE THIS** | Reduces word repetition |
| `presence_penalty` | ❌ Not supported | ✅ **USE THIS** | Encourages new topics |

**Conversion:**
- `repeat_penalty: 1.1` ≈ `frequency_penalty: 0.3`
- Higher values = less repetition

---

## Alternative Locations

If you don't see the parameter on the model edit page, check:

### Location 1: Admin Settings → Models
1. **Admin Panel** → **Settings** → **Models**
2. Look for **"Default Model Parameters"**
3. Remove `repeat_penalty` from defaults

### Location 2: Connections → OpenAI
1. **Admin Panel** → **Connections**
2. Find **OpenAI** connection
3. **Edit** → **Advanced Settings**
4. Remove `repeat_penalty`

### Location 3: Global Settings
1. **Admin Panel** → **Settings** → **Advanced**
2. Look for **"Model Parameters"**
3. Remove `repeat_penalty` from global defaults

---

## Verify It's Fixed

After making the change:

1. **Test with your team charter query:**
   - Upload: Team Charter Rubric.txt
   - Upload: Assignment Instructions.txt
   - Upload: Course Overview.txt
   - Ask: "Create a team charter draft"

2. **Should work without errors!** ✅

3. **If still errors:**
   - Check browser console (F12)
   - Verify OpenAI API key is valid
   - Try refreshing page (hard refresh: Cmd+Shift+R)

---

## For Future Reference

### OpenAI-Supported Parameters:

```json
{
  "temperature": 0.7,           // Creativity (0.0-2.0)
  "top_p": 1.0,                 // Nucleus sampling (0.0-1.0)
  "frequency_penalty": 0.3,     // Reduce repetition (0.0-2.0)
  "presence_penalty": 0.0,      // Encourage new topics (0.0-2.0)
  "max_tokens": 4096,           // Max response length
  "stream": true                // Stream responses
}
```

### NOT Supported by OpenAI:
- ❌ `repeat_penalty`
- ❌ `top_k`
- ❌ `mirostat`
- ❌ `mirostat_tau`
- ❌ `mirostat_eta`

---

## Quick Reference Card

**For OpenAI models (GPT-4, GPT-4o, GPT-5):**

```
✅ USE:
  - temperature
  - top_p
  - frequency_penalty
  - presence_penalty
  - max_tokens

❌ DON'T USE:
  - repeat_penalty
  - top_k
  - mirostat
```

---

**Fixed?** Great! Now you can use file uploads with your OpenAI models! 🎉

**Still having issues?** Check:
1. OpenAI API key is set correctly
2. Model name is correct (e.g., "gpt-4o" not "gpt4o")
3. API has sufficient credits
4. Network connectivity to OpenAI

---

**Next:** Upload your course documents and start using RAG! 📚

