# 🎛️ OpenAI Parameters Reference (GPT-5, GPT-4o, GPT-4)

**Quick reference for configuring OpenAI models in Open WebUI**

---

## ⚠️ Parameters to DELETE

**These will cause "Unknown parameter" errors with OpenAI:**

```
❌ repeat_penalty: [any value]
❌ top_k: [any value]
❌ mirostat: [any value]
❌ mirostat_tau: [any value]
❌ mirostat_eta: [any value]
❌ num_predict: [any value]
❌ tfs_z: [any value]
❌ typical_p: [any value]
❌ repeat_last_n: [any value]
❌ penalize_newline: [any value]
❌ num_ctx: [any value]
❌ num_batch: [any value]
❌ num_gpu: [any value]
❌ main_gpu: [any value]
❌ low_vram: [any value]
❌ f16_kv: [any value]
❌ vocab_only: [any value]
❌ use_mmap: [any value]
❌ use_mlock: [any value]
❌ num_thread: [any value]
```

**Why?** These are all **local model parameters** (Ollama, LLaMA, etc.) and are **not recognized by OpenAI's API**.

---

## ✅ Parameters to USE (OpenAI Models)

### Complete Valid Configuration

```json
{
  "model": "gpt-4o",
  "temperature": 0.7,
  "top_p": 1.0,
  "frequency_penalty": 0.3,
  "presence_penalty": 0.0,
  "max_tokens": 4096,
  "stream": true,
  "stop": null,
  "logit_bias": null,
  "user": null,
  "seed": null
}
```

---

## 📊 Parameters Chart

### Core Parameters (Most Common)

| Parameter | Type | Range | Default | Purpose |
|-----------|------|-------|---------|---------|
| **`temperature`** | float | 0.0 - 2.0 | 0.7 | Randomness/creativity level |
| **`top_p`** | float | 0.0 - 1.0 | 1.0 | Nucleus sampling (diversity) |
| **`max_tokens`** | int | 1 - model max | varies | Maximum response length |
| **`frequency_penalty`** | float | -2.0 - 2.0 | 0.0 | Reduce word repetition |
| **`presence_penalty`** | float | -2.0 - 2.0 | 0.0 | Encourage new topics |

### Additional Parameters (Less Common)

| Parameter | Type | Values | Purpose |
|-----------|------|--------|---------|
| **`stream`** | bool | true/false | Stream responses word-by-word |
| **`stop`** | array/string | ["###", "\n"] | Stop sequences |
| **`logit_bias`** | object | {token_id: bias} | Adjust token probabilities |
| **`user`** | string | any string | User identifier for tracking |
| **`seed`** | int | any integer | Reproducible outputs |
| **`n`** | int | 1-10 | Number of completions |
| **`logprobs`** | bool | true/false | Include log probabilities |
| **`top_logprobs`** | int | 0-20 | Number of logprobs to return |

---

## 🎯 Recommended Settings by Use Case

### 1. Academic Writing (Your Primary Use)

```json
{
  "temperature": 0.7,
  "top_p": 1.0,
  "frequency_penalty": 0.3,
  "presence_penalty": 0.2,
  "max_tokens": 4096
}
```

**Best for:**
- Team charters
- Course assignments
- Research papers
- Professional writing
- Thesis/dissertation work

**Why these values:**
- `0.7 temp` - Balanced creativity and consistency
- `0.3 freq` - Avoids repetitive phrasing
- `0.2 pres` - Explores related concepts naturally
- `4096 tokens` - Handles long-form academic content

---

### 2. Creative Writing

```json
{
  "temperature": 0.9,
  "top_p": 1.0,
  "frequency_penalty": 0.5,
  "presence_penalty": 0.6,
  "max_tokens": 4096
}
```

**Best for:**
- Blog posts from voice notes
- Storytelling
- Brainstorming
- Exploratory writing
- Personal journaling

---

### 3. Technical/Factual Content

```json
{
  "temperature": 0.3,
  "top_p": 0.95,
  "frequency_penalty": 0.0,
  "presence_penalty": 0.0,
  "max_tokens": 4096
}
```

**Best for:**
- Technical documentation
- Factual summaries
- Data analysis
- Research synthesis
- Citation work

---

### 4. Code Generation

```json
{
  "temperature": 0.2,
  "top_p": 0.95,
  "frequency_penalty": 0.0,
  "presence_penalty": 0.0,
  "max_tokens": 8000
}
```

**Best for:**
- Writing code
- Debugging
- Technical solutions
- API integration
- Script generation

---

### 5. Brainstorming/Ideation

```json
{
  "temperature": 1.0,
  "top_p": 1.0,
  "frequency_penalty": 0.7,
  "presence_penalty": 0.8,
  "max_tokens": 2000
}
```

**Best for:**
- Generating ideas
- Problem exploration
- Creative solutions
- Research questions
- Alternative approaches

---

## 🔍 Parameter Deep Dive

### `temperature` (Randomness/Creativity)

**Scale:** 0.0 (deterministic) → 2.0 (very random)

```
0.0 - 0.2   ████░░░░░░  Very focused, consistent, factual
0.3 - 0.5   █████░░░░░  Slightly varied, still focused
0.6 - 0.8   ██████░░░░  Balanced creativity & consistency ⭐
0.9 - 1.2   ████████░░  Creative, diverse, exploratory
1.3 - 2.0   ██████████  Very experimental (rarely used)
```

**Example outputs for "Explain team learning":**

**temp: 0.2**
> "Team learning is the process by which groups acquire knowledge..."
> (Always similar, consistent)

**temp: 0.7** ⭐ Recommended
> "Team learning emerges when members collectively reflect..."
> (Varied but accurate)

**temp: 1.2**
> "Imagine a team as a living organism, constantly evolving..."
> (Creative, metaphorical)

---

### `frequency_penalty` (Reduce Repetition)

**Scale:** -2.0 (encourage) ← 0.0 (neutral) → 2.0 (strongly discourage)

```
-1.0        Encourages word repetition (rarely useful)
 0.0        No penalty (default)
 0.3 ⭐      Subtle reduction (recommended)
 0.5        Moderate reduction
 0.7        Strong reduction
 1.0+       Very strong (may sound unnatural)
```

**Example:**

**freq: 0.0**
> "The team charter helps teams collaborate. The team charter guides team behavior. The team charter ensures team success."

**freq: 0.3** ⭐
> "The team charter helps groups collaborate effectively. This document guides member behavior and ensures collective success."

**freq: 0.7**
> "The team charter facilitates collaboration. This foundational document establishes behavioral norms while promoting shared achievement."

---

### `presence_penalty` (Encourage New Topics)

**Scale:** -2.0 (stay focused) ← 0.0 (neutral) → 2.0 (explore widely)

```
-0.5        Stay tightly on topic
 0.0        No encouragement (default)
 0.2 ⭐      Gentle exploration (recommended)
 0.5        Moderate topic diversity
 0.8        Strong encouragement
 1.0+       Very exploratory (may jump topics)
```

**Example:**

**pres: 0.0**
> Stays tightly focused on the exact topic asked about

**pres: 0.2** ⭐
> Introduces related concepts naturally, makes connections to broader context

**pres: 0.7**
> Explores multiple angles, introduces various related topics, broad perspective

---

### `max_tokens` (Response Length)

**Common values:**
```
500     Short answers, quick responses
1000    Standard responses
2000    Detailed explanations
4096    Long-form content ⭐ (recommended)
8000    Very long responses (code, documents)
16000   Maximum for most models
```

**Note:** Tokens ≈ 0.75 words (rough estimate)
- 1000 tokens ≈ 750 words
- 4096 tokens ≈ 3,000 words

---

## 🔄 Parameter Conversion Guide

**Moving from local models to OpenAI?**

| Local Model (Ollama) | OpenAI Equivalent |
|---------------------|-------------------|
| `repeat_penalty: 1.1` | `frequency_penalty: 0.3` |
| `repeat_penalty: 1.3` | `frequency_penalty: 0.6` |
| `repeat_penalty: 1.5` | `frequency_penalty: 0.9` |
| `top_k: 40` | Built into `top_p: 0.9` |
| `num_predict: 2048` | `max_tokens: 2048` |

---

## ⚙️ Advanced Parameters (Rarely Needed)

### `stop` (Stop Sequences)

```json
{
  "stop": ["\n\n", "###", "END"]
}
```

**Use when:** You want generation to stop at specific strings

---

### `seed` (Reproducible Outputs)

```json
{
  "seed": 12345
}
```

**Use when:** You need identical outputs for testing/debugging

---

### `logit_bias` (Token Probability Adjustment)

```json
{
  "logit_bias": {
    "50256": -100,  // Strongly discourage token ID 50256
    "12345": 100    // Strongly encourage token ID 12345
  }
}
```

**Use when:** You need fine-grained control over specific words/tokens

---

### `n` (Multiple Completions)

```json
{
  "n": 3
}
```

**Use when:** You want multiple different responses to choose from

---

## 🎨 Combining Parameters Effectively

### General Guidelines

1. **Start with defaults:**
   ```json
   {
     "temperature": 0.7,
     "top_p": 1.0,
     "frequency_penalty": 0.0,
     "presence_penalty": 0.0
   }
   ```

2. **Adjust one at a time:**
   - Change temperature first
   - Then add frequency_penalty if needed
   - Then add presence_penalty if needed

3. **Avoid extremes:**
   - Keep temperature < 1.2
   - Keep penalties < 1.0
   - Adjust gradually (±0.1-0.2)

4. **Test and iterate:**
   - Try a prompt
   - Adjust based on results
   - Compare outputs

---

### Common Combinations

**Consistent + Focused (Technical Writing):**
```json
{
  "temperature": 0.3,
  "top_p": 0.95,
  "frequency_penalty": 0.0,
  "presence_penalty": 0.0
}
```

**Balanced + Natural (General Use):** ⭐
```json
{
  "temperature": 0.7,
  "top_p": 1.0,
  "frequency_penalty": 0.3,
  "presence_penalty": 0.0
}
```

**Creative + Diverse (Brainstorming):**
```json
{
  "temperature": 0.9,
  "top_p": 1.0,
  "frequency_penalty": 0.5,
  "presence_penalty": 0.6
}
```

---

## 🐛 Troubleshooting

### Problem: Outputs are too repetitive

**Solution:**
```json
{
  "frequency_penalty": 0.5,  // Increase this
  "presence_penalty": 0.3    // Add this
}
```

---

### Problem: Outputs are too random/inconsistent

**Solution:**
```json
{
  "temperature": 0.5,  // Decrease this
  "top_p": 0.95        // Decrease this
}
```

---

### Problem: Outputs are too short

**Solution:**
```json
{
  "max_tokens": 8000  // Increase this
}
```

---

### Problem: Getting "Unknown parameter" errors

**Solution:**
1. Check for local model parameters (see DELETE list above)
2. Remove: `repeat_penalty`, `top_k`, `mirostat`, etc.
3. Use only OpenAI-supported parameters

---

### Problem: Outputs stay too focused on one topic

**Solution:**
```json
{
  "presence_penalty": 0.5,  // Increase this
  "temperature": 0.8        // Increase this
}
```

---

## 📋 Quick Reference Card

**Copy this for your model:**

### For Academic Work (educate-barry):
```json
{
  "temperature": 0.7,
  "top_p": 1.0,
  "frequency_penalty": 0.3,
  "presence_penalty": 0.2,
  "max_tokens": 4096,
  "stream": true
}
```

### For Creative Writing:
```json
{
  "temperature": 0.9,
  "top_p": 1.0,
  "frequency_penalty": 0.5,
  "presence_penalty": 0.6,
  "max_tokens": 4096,
  "stream": true
}
```

### For Technical/Code:
```json
{
  "temperature": 0.2,
  "top_p": 0.95,
  "frequency_penalty": 0.0,
  "presence_penalty": 0.0,
  "max_tokens": 8000,
  "stream": true
}
```

---

## 🔗 Model Configuration Location

**Your Open WebUI:**
- Go to: https://ai.opshub.host/workspace/models/edit?id=educate-barry
- Or: **Workspace** → **Models** → **Edit** (educate-barry)

**Find the Parameters section and:**
1. **DELETE** all local model parameters (see list above)
2. **KEEP** only OpenAI-supported parameters
3. **ADD** frequency_penalty and presence_penalty if missing
4. **SAVE** changes

---

## 📚 Additional Resources

**Official OpenAI API Docs:**
- https://platform.openai.com/docs/api-reference/chat/create

**Model Context Windows:**
- GPT-4o: 128,000 tokens
- GPT-4: 8,192 tokens (or 32k variant)
- GPT-3.5-turbo: 16,385 tokens

**Rate Limits:**
- Varies by tier
- Check: https://platform.openai.com/account/rate-limits

---

## ✅ Checklist for Your educate-barry Model

- [ ] Remove `repeat_penalty`
- [ ] Remove `top_k` (if present)
- [ ] Remove `mirostat` (if present)
- [ ] Remove any other local model parameters
- [ ] Add `frequency_penalty: 0.3`
- [ ] Add `presence_penalty: 0.2` (optional)
- [ ] Set `temperature: 0.7`
- [ ] Set `max_tokens: 4096`
- [ ] Save configuration
- [ ] Test with file upload
- [ ] Verify no "Unknown parameter" errors

---

## 💡 Pro Tips

1. **Save multiple model configs:**
   - Create "educate-barry-creative" (higher temp)
   - Create "educate-barry-technical" (lower temp)
   - Create "educate-barry-balanced" (default)

2. **Test before important work:**
   - Always test with small sample first
   - Verify file uploads work
   - Check response quality

3. **Adjust based on feedback:**
   - Too repetitive? → Increase frequency_penalty
   - Too random? → Decrease temperature
   - Too brief? → Increase max_tokens

4. **Document what works:**
   - Save successful configurations
   - Note what works for different tasks
   - Share with team if applicable

---

**Last Updated:** October 29, 2025  
**For:** Open WebUI at https://ai.opshub.host/  
**Model:** educate-barry (and all OpenAI models)

---

**Questions?** Everything you need is in this guide! 🎯

