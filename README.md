# Sponsor this project
![image](https://github.com/user-attachments/assets/b28741c6-5bc5-4bd1-a53a-9364a0acdf3d)
[Buy me a coffee ☕](https://buymeacoffee.com/calirenato82)

![image](https://simpleicons.org/icons/linkedin.svg) [Connect on LinkedIn](https://www.linkedin.com/in/calirenato82)


# JTBD Mapper AI Agent 🤖 Free & Open-Source
Remember to periodically check for a new version of the Joby Labs Agent at https://github.com/renatocaliari/joby-labs-agent.

### 🇺🇸 **English:**
The Joby Labs Agent is a collection of specific instructions and artificial intelligence prompts used for Jobs To Be Done mapping.

It's configured to work within [Cline](https://github.com/cline/cline), a free and open-source extension for VS Code — an IDE commonly used for systems development.

You can use free LLMs such as Gemini 2.0, Llama 3.3, and Qwen 2.5.

With this combination, you can have an autonomous agent that performs mapping autonomously. It only asks questions to confirm options you want to proceed with to the next stages.

Important: You **don't** need to know how to program.

### 🇧🇷 **Brazilian Portuguese:**
O Joby Labs Agent é uma coleção de instruções específicas e prompts de inteligência artificial utilizado para mapeamento de **Jobs To Be Done**. 

Ele é configurado para funcionar dentro do [Cline](https://github.com/cline/cline), [uma extensão gratuita](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev) e open-source do VS Code - uma IDE comumente utilizada para desenvolvimento de sistemas.

Você pode usar LLMs gratuitas como Gemini 2.0, Llama 3.3, Qwen 2.5.

Com essa combinação você pode ter um agente autônomo que faz um mapeamento de forma autônoma. Ele só faz perguntas para confirmar opções que você deseja para avançar para próximos estágios.

Importante: Você **não** precisa saber programar.

# Steps

1. Open your terminal: Search for "terminal" or "command prompt" on your computer and open the appropriate application.
2. Navigate to the desired directory: Use the cd command to navigate to the directory where you want to create the Jobs-to-be-Done mappings. For example, if you want to create them in your Downloads folder, you would type `cd ~/Downloads` and press Enter.
3. Run the following command: Once you're in the desired directory to create jobs-to-be-done mappings, paste the following command into your terminal and press Enter:
```
curl https://raw.githubusercontent.com/renatocaliari/joby-labs-agent/main/script_setup.sh | bash
```
4. [Download VS Code and install](https://code.visualstudio.com/download).
5. Open VS Code.
6. [Install the extension Cline](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev).
7. Open Cline's settings.
8. [Generate an API key in Google AI Studio](https://aistudio.google.com/app/apikey) to be able to use the LLM Google's Gemini for free.
     - Go to [Google AI Studio](https://aistudio.google.com/app/apikey).
     - Click on Create API Key.
     - Select the project "Generative Language Client" or any other with a free-of-charge plan.
     - Click on Create API key in existing project.
     - Click on Copy.
10. Go back to Cline's settings and select "Google Gemini" as the API Provider.
11. Paste the API key into the "Gemini API key" field. Then, select the "gemini-2.0-flash-thinking-exp-1219" model or a newer one, or any other you wish to try.
12. Click the File menu and then Open Folder. Find the folder you ran the script in step 1 and open the folder "joby-labs-agent".
13. Open the file custom_instructions.md and copy the content.
14. Paste the content copied in step 5 into Cline's Custom Instructions configuration.
15. Click DONE after finishing the settings.
16. In the Cline chat, check "Auto-approve: ..."
17. Then, intype a message like ```generate a job map for "xyz"``` and press Enter.
18. Your maps will be generated within the xxx directory in subdirectories created by the agent in this format: `{currentdate_and_time}_{job to be done}_docs`.

# Free LLM Alternatives

You can use other providers to try different LLMs, like:

### glhf.chat: Qwen and Llama
To try Llama 3.3 or Qwen 2.5 free of charge, create an API key at `https://glhf.chat/users/settings/api`. 

Then, in Cline's settings, configure the provider to 'OpenAI Compatible' and the Base URL to `https://glhf.chat/api/openai/v1`. 

Paste `hf:meta-llama/Llama-3.3-70B-Instruct` as the model to use Llama 3.3, or 'hf:Qwen/Qwen2.5-72B-Instruct' for Qwen 2.5.

### hyperbolic: DeepSeek V3, Qwen and Llama

To try DeepSeek V3, Llama 3.3 or Qwen 2.5 free of charge, create an API key at `https://app.hyperbolic.xyz/`. 

Then, in Cline's settings, configure the provider to 'OpenAI Compatible' and the Base URL to `https://api.hyperbolic.xyz/v1`. 

Paste `deepseek-ai/DeepSeek-V3` as the model to use DeepSeek V3.


# Troubleshooting

You might occasionally encounter an "API Request Failed" error with the message "Too many requests". 
This is a common occurrence with free usage plans, often due to rate limiting or resource exhaustion. To resolve this, simply wait a short period and then click "Retry." 

Google's Gemini 2.0 is a powerful LLM that is currently offered for free, making the occasional need to retry a reasonable trade-off.

![image](https://github.com/user-attachments/assets/2048aa50-ecef-4868-a6c5-8d11f91073d0)

Error content:
```
[GoogleGenerativeAI Error]: Error fetching from https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-thinking-exp-1219:streamGenerateContent?alt=sse: [429 Too Many Requests] Resource has been exhausted (e.g. check quota)."
```


# 🇧🇷 Jobs To Be Done & Prompts 
- Para mais informações sobre Jobs To Be Done, consulte o [e-book gratuito Estratégia e Inovação baseadas em Jobs To Be Done](https://calirenato82.substack.com/p/e-book-jobs-to-be-done-em-portugues).
- Para encontrar mais prompts de I.A., [clique aqui](https://calirenato82.substack.com/i/141662256/prompts-ia-para-problem-space).


# Images

![image](https://github.com/user-attachments/assets/3df8027b-b28a-4ffe-aed9-7a20d05cbd8e)

![Screenshot 2024-12-20 14 14 04](https://github.com/user-attachments/assets/a804d740-7e51-4568-923a-c04d27670755)

![Screenshot 2024-12-20 14 19 13](https://github.com/user-attachments/assets/f84ed0d1-2207-459b-aea4-673fcfe1c644)

