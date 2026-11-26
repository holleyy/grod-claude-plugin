# GRØD for Claude and Codex

Ask Claude or Codex about the meetings GRØD recorded on your Mac. They can
search them, read what was decided and who owns each action, and find what
someone said and when they said it. They can't change, add or delete anything
in GRØD.

## What you need

- GRØD on the same Mac.
- **Allow MCP apps** turned on in GRØD's settings. It is off until you turn
  it on.
- Claude Code, a Cowork task that runs on your Mac, or Codex. Ordinary Claude
  and ChatGPT chats, on the web, on your phone or in the desktop apps, don't
  start servers on your Mac, so they can't reach GRØD.

## Install

### Claude Code

In Claude Code 2.1.275 or later:

```
/plugin install grod --marketplace holleyy/grod-plugin
```

In an older Claude Code, add the marketplace first, then install:

```
/plugin marketplace add holleyy/grod-plugin
/plugin install grod@gaspery
```

### Codex

```
codex plugin marketplace add holleyy/grod-plugin
codex plugin add grod@gaspery
```

## What to ask

Ask in your own words and the app picks the right skill. In Claude Code you
can also start one by name:

| Skill | Use it for |
|---|---|
| `/grod:prep` | Before a meeting: what you agreed last time, what is still open, and what to raise. |
| `/grod:decisions` | What was decided and what is still open on a topic, a project or with a person. |
| `/grod:recap` | A recap of one meeting or a set of them, such as a week with one team. Ask it to check against the transcript, and it checks each decision and action against the lines it came from. |
| `/grod:find` | Where something was said, who said it and when. |

For example:

> I have a one-to-one with Sam this afternoon. What have we agreed about the
> pricing page, and what is still open?

> Find the interview with Priya Shah and list every question I asked, with
> the time it came up.

## How it works

The plugin has no server of its own. GRØD has one built in. When the app
starts, `scripts/grod-mcp.sh` finds your copy of GRØD and starts it with one
argument, `--mcp-stdio`. The app then talks to GRØD over standard input and
output. The script looks for the copy of GRØD that is running, then
`/Applications`, then `~/Applications`, then any copy Spotlight knows. To use
a development build, set `GROD_APP` to its path.

Each app reads its own manifest, `.claude-plugin/plugin.json` for Claude and
`.codex-plugin/plugin.json` for Codex. Both use the same skills and the same
script.

GRØD's server has four read-only tools:

| Tool | What it does |
|---|---|
| `search_records` | Searches your meetings, people and tags. |
| `read_meeting` | Reads a meeting's overview and one part of it, a page at a time: transcript lines, actions, decisions, risks or bookmarks. |
| `export_meeting_markdown` | Returns a meeting's summary, notes or transcript as Markdown, in chunks. |
| `list_meetings` | Lists your meetings newest first, between two dates if you give them, a page at a time. |

Versions of GRØD before `list_meetings` have the first three. The skills
still work with them, but answers about a period may miss meetings.

GRØD reads its meeting store with saving turned off and opens no network
connection for this. It keeps a temporary search index while the app is
connected and deletes it when the app disconnects. If **Allow MCP apps** is
off, GRØD refuses to start the server.

The skills in `skills/` are instructions for the app: which tool to use for
which question, and how to answer from what it reads.

## Privacy Policy

**What this plugin collects.** Nothing. The plugin sends nothing to Gaspery
Limited or anyone else, and has no analytics.

**What leaves your Mac.** What Claude or Codex reads from GRØD becomes part of
your conversation with it. Like the rest of the conversation, it goes to the
company that runs the app: Anthropic for Claude, under Anthropic's terms and
your Claude privacy settings, or OpenAI for Codex, under OpenAI's terms and
your OpenAI account's data controls. Ask only about meetings you are happy to
share with that company.

**Storage and retention.** The plugin stores nothing. Your meetings stay in
GRØD. GRØD's temporary search index lasts only while the app is connected.

**Third parties.** Anthropic or OpenAI, as above, depending on the app you
use. No one else.

**Turning it off.** Switch off **Allow MCP apps** in GRØD, or remove the
plugin from Claude or Codex.

**Contact.** alex@gaspery.com. GRØD's full privacy policy is at
https://gaspery.com/grod/privacy-policy/.

## Licence

Everything in this repository is under the MIT licence in [LICENSE](LICENSE),
except the GRØD name and icon (`icon.png`). Those belong to Gaspery Limited and
the licence doesn't cover them. If you adapt this plugin, give it your own name
and icon, and don't present it as made or endorsed by Gaspery Limited.
