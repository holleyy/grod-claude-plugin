# GRØD for Claude

Ask Claude about the meetings GRØD recorded on your Mac. Claude can search
them, read what was decided and who owns each action, and find what someone
said and when they said it. It can't change, add or delete anything in GRØD.

## What you need

- GRØD on the same Mac as Claude.
- **Allow MCP apps** turned on in GRØD's settings. It is off until you turn
  it on.
- Claude Code, or a Cowork task that runs on your Mac. Claude chats on the
  web, on your phone and in the desktop app don't start servers on your Mac,
  so this plugin's skills load there but can't reach GRØD.

## What to ask

Ask in your own words and Claude picks the right skill, or start one by name:

| Skill | Use it for |
|---|---|
| `/grod:prep` | Before a meeting: what you agreed last time, what is still open, and what to raise. |
| `/grod:decisions` | What was decided and what is still open on a topic, a project or with a person. |
| `/grod:recap` | A recap of one meeting or a set of them, such as a week with one team. |
| `/grod:find` | Where something was said, who said it and when. |

For example:

> I have a one-to-one with Sam this afternoon. What have we agreed about the
> pricing page, and what is still open?

> Find the interview with Priya Shah and list every question I asked, with
> the time it came up.

## How it works

The plugin has no server of its own. GRØD has one built in. When Claude
starts, `scripts/grod-mcp.sh` finds your copy of GRØD and starts it with one
argument, `--mcp-stdio`. Claude then talks to GRØD over standard input and
output. The script looks for the copy of GRØD that is running, then
`/Applications`, then `~/Applications`, then any copy Spotlight knows. To use
a development build, set `GROD_APP` to its path.

GRØD's server has three read-only tools:

| Tool | What it does |
|---|---|
| `search_records` | Searches your meetings, people and tags. |
| `read_meeting` | Reads a meeting's overview and one part of it, a page at a time: transcript lines, actions, decisions, risks or bookmarks. |
| `export_meeting_markdown` | Returns a meeting's summary, notes or transcript as Markdown, in chunks. |

GRØD reads its meeting store with saving turned off and opens no network
connection for this. It keeps a temporary search index while Claude is
connected and deletes it when Claude disconnects. If **Allow MCP apps** is
off, GRØD refuses to start the server.

The skills in `skills/` are instructions for Claude: which tool to use for
which question, and how to answer from what it reads.

## Privacy Policy

**What this plugin collects.** Nothing. The plugin sends nothing to Gaspery
Limited or anyone else, and has no analytics.

**What leaves your Mac.** What Claude reads from GRØD becomes part of your
conversation with Claude. Like the rest of the conversation, it goes to
Anthropic, which runs Claude, under Anthropic's terms and your Claude privacy
settings. Ask only about meetings you are happy to share with Claude.

**Storage and retention.** The plugin stores nothing. Your meetings stay in
GRØD. GRØD's temporary search index lasts only while Claude is connected.

**Third parties.** Anthropic, as above. No one else.

**Turning it off.** Switch off **Allow MCP apps** in GRØD, or remove the
plugin from Claude.

**Contact.** alex@gaspery.com. GRØD's full privacy policy is at
https://gaspery.com/grod/privacy-policy/.
