Rules:
- Always read the instruction file inside prompts_docs as your specific prompt to execute each task and generate the proper result in the project folder.
- Use the table below as your roadmap.
- Generate result files only when the relevant step is reached.

Roadmap with all steps:
| Done? | Step | Customm prompt: File to read | Result: File to generate | Sub-Tasks |
|---|---|---|---|---|
| [ ] | Discover Actors | `prompts_docs/actors.md` | `result_docs/actors.md` | 1. List the roles and actors in the file.<br>2. In the chat list only the titles containing "{role}: {actor}" preceded by sequential number. |
| [ ] | Ask for the actor | none | none | 1. Ask the user to choose one actor to proceed and store in `user_options.md`. |
| [ ] | Determine Market Definition on focus | none | none | Update user_options.md to present the Segment Market Definition on focus after knowing the answer about the actor: "Market definition: {actor} trying to {job to be done}". |
| [ ] | Discover Related Jobs | `prompts_docs/related_jobs.md` | `result_docs/related_jobs.md` | 1. List all possible functional jobs in the file.<br>2. Only if the job to be done is a solution or specific technology, list in the chat the titles of related jobs preceded by sequential numbers. Ask the user to choose one to proceed in the chat and store it in `user_options.md`. The answer will be the "Main Functional Job To Be Done". Otherwise, if the job to be done is not a solution, store it in `user_options.md`. |
| [ ] | Discover Job Factors | `prompts_docs/job_factors.md` | `result_docs/job_factors.md` | 1. Discover all job factors related to the Market Definition 2. List all in the file. |
| [ ] | Discover Segments | `prompts_docs/segments.md` | `result_docs/segments.md` | <br>1. Use the found situational factors and variables from the previous step as input in the prompt of next sub-task. <br>3. Run the prompt of `segments.md` to discover segments and write in the result file. |
| [ ] | Ask for the segment | none | none | 1. Show the list of the segments titles found in the previous steps preceded by sequential numbers and the text "[Segment], adding the market definition of the given job to be done as the first option as "1. [Market] {fill market definition here}".<br>2. Ask the user to choose one and store in `user_options.md`. |
| [ ] | Discover Emotional and Social Jobs | prompts_docs/emotional_social_jobs.md | `result_docs/emotional_social_jobs.md` | List all possible emotional jobs and social jobs in the file. | 
| [ ] | Discover Related Jobs | `prompts_docs/related_jobs.md` | `result_docs/segment_related_jobs.md` | 1. List all possible related functional jobs in the file related to the market of the segment. |
| [ ] | Discover Segment Actors | `prompts_docs/actors.md` | `result_docs/segment_actors.md` | 1. List the roles and actors in the file related to the selected segment.<br>2. In the chat list only the titles containing "{role}: {actor}" preceded by sequential number. |
| [ ] | Ask for the actor | none | none | 1. Ask the user to choose one actor to proceed and store in `user_options.md` as `Segment Actor`. |
| [ ] | Determine Segment Market Definition on focus | none | none | Update user_options.md to present the Segment Market Definition on focus after knowing the answer above following this structure: "Segment Market definition: {segment market definition}". |
| [ ] | Discover Job Factors for the segment | `prompts_docs/job_factors.md` | `result_docs/segment_job_factors.md` | 1. Discover all job factors related to the Market Definition of the segment 2. List all in the file. |
| [ ] | Discover Job Steps | `prompts_docs/job_steps.md` | `result_docs/segment_job_steps.md` | 1. List all job steps related to the market on focus . 2. Each job step need to have the placeholder `[ ]` at the begninning.   |
| [ ] | Discover finance success criteria for the Market Definition of the segment | `prompt_docs/success_criteria_finance.md` | `result_docs/success_criteria_finance.md` | Discover as many as possible. |
| [ ] | Discover success criteria for each job step | `result_docs/success_criteria_needs.md` | `result_docs/segment_job_map.md` | 1. Iterate through each job step in `result_docs/segment_job_steps.md` and run the prompt `success_criteria_needs.md` for each one separately, informing the Segment Market definition as the Job To Be Done and the content from `prompt_docs/job_factors.md`.<br>2. In each iteration, add the result with the list of success criteria in `result_docs/segment_job_map.md` as this template: ## {Stage} \n ## {Job Step}: {Brief description}\n {list of success criteria}.<br>3. In the file segment_job_steps.md mark each Job Step as done [X] once you discover its success criteria and save it to the file. |
