
# CSL Next

At a high level CSL is an XML DSL that sets some context-dependent parameters and provides templates for inline and block formatting of lists (citations and bibliographies respectively).
But it has no method for extension, so any change in behavior requires changes in the XML model, and often, by extension, the styles, _and_ the input schema.
Given the diversity of software implementations and thousands of styles, the lack of extensibility enforces a large degree of inertia that we need to address.

## Goals

- provide a simpler and more consistent core syntax model, that we can maintain as stable going forward
- designed from the (re)beginning to be multilingual and support multiple output modes
- make extension and future development and maintenance of schema, styles and processing engines much easier
- make writing new styles easier, including potentially providing an alternative, non-XML, syntax

## Style model

A style includes:

: `citation`

a delimited inline list of `citation-reference` objects.

: `citation-reference`

an object that references a bibliographic resource.

: `bibliography`

a delimited block list of `bibliography-reference` objects.

: `bibliography-reference`

an object that describes a bibliography resource.

: `templates`

a list of `template` objects.

: `template`

a sequence of layout and formatting instructions.

## Configuration

Processing is configured with attributes on the relevant elements.

## Templates

A template is an optionally-named description of how to map CSL input data variable strings, and other partial template output strings, to final output.

A collection of templates can be contained:

- at the top-level, for use across citation and bibliography
- in citation and/or bibliography
- in a standalone file

The CSL project provides a collection of template files for use in styles in **URL to DIR**. 
The CSL-hosted style files in turn incorporate these templates.

### Rendering Elements

Templates may include one-or-more of the following two rendering elements:

#### List

A `list` describes how to format a delimited list of strings to final output string.
When a `list` is empty, it does not render.

#### Text

A `text` element places a variable or template string output in a sequence, and formats it with surrounding punctuation, fonts, etc.

### Rendering Attributes

#### Transforms

Transforms are named operations that modify input data to output strings. 
Examples include transforming:

- lists of author names to initialize given names and truncate long lists
- dates into human-readable form; years, months, etc.
- shorten titles

A few standard transform attributes (for shortening or grouping lists, for example) have been adapted from CSL 1.0.

In addition, a new `cs:transforms` attribute is available for arbitrary transforms.

## Input data-types

This includes an accompanying JSON schema in YAML.
It expresses the following input data-types.

TODO the below needs more thought, and may not work generally

Structured data-types also have string analogs available. 
Where such a variable is a `list`, the string shall be semi-colon-separated.
Where it is an `object`:

 - personal names TODO
 - otherwise, the string shall be colon-separated
 
```yaml
author: Doe, Jane; Smith, Sam
```

### Lists

- contributors
- locators

### Objects

- contributor
- title
- locator

### Dates

CSL NEXT expects dates to be `EDTF` level 0 or 1 strings, with option for a seasonal range extension.

### Strings

All other variables are strings.

## Appendix

### Example

The following example fragment shows:

- the simplified and unified syntax/model
- the `cs:mode` attribute, which does not exist in CSL currently, and would allow support for locally-modified citations
- `cs:transforms` attribute

```xml
    <!-- configure sort/group in templates -->
    <if mode="narrative">
      <render-list delimiter=", "
                   group-by="author" sort="author">
	      <render-item template="apa-authors"/>
	      <render-list prefix="(" suffix=")">
          <render template="date-year"/>
          <render template="citation-locator"/>
	    </render-list>
      </render-list>
    </if>
```
