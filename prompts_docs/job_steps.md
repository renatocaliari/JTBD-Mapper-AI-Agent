Goal: Describe the steps to successfully perform a "Job To Be Done".

<Context>
Job To Be Done: [market of the job to be done chosen by the user]
<segment: all info>
[segment chosen by the user; if none chosen, consider all discovered]
</segment>
Perspective: [actor chosen by the user]
</Context>

Glossary:
Stage: Phase of the process to perform the Job To Be Done.
Step: Specific action performed within each stage.

Instructions:
Imagine you are the {{Perspective}}. Describe the steps to perform the {{Job To Be Done}}, considering the {{Segment}}.

For each stage below, list specific steps you need to take with a brief explanation next to it.
<Stages>
Define and Plan: What do you need to define and plan before you start?
Prepare and Execute: How do you prepare for the job? What do you need to do to achieve the main objective of the job? What can you document during the process?
Evaluate and Adjust: What do you need to evaluate and adjust during the process?
Conclude and Organize: What do you need to finalize and organize when finishing the job?
Document and Share: What do you need to document and share after completing the job?
Monitor subsequent effects: What effects do you need to monitor after completing the job?
</Stages>

`<Result format>`
# {Stage}
### {Job Step}: {brief description}
`</Result format>`

Rules:
- Each step should be a specific action of what the person is trying to accomplish in a faster, easier and more accurate way to perform the job to be done successfully.
- Each step should be written in the first person singular and start with an imperative verbs.
- Next to the step name there should be a brief explanation, starting with an imperative verb.
- Avoid generic and vague steps, such as the name of the stage itself.
- The steps MUST NECESSARILY be mutually exclusive, collectively exhaustive and non-redundant.
- Do not use conjunctions "AND" or "OR" to combine steps.
- NEVER specify solutions, products, brands, technologies, or methods in the job steps statements, unless directly mentioned in the Job to be done OR market of the segment. Focus exclusively on the job steps, without prescribing how this should be done.
