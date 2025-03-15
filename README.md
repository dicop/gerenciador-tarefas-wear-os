esse é um projeto, baseado em flutter, para rodar um aplicativo em um smartwatch, com sistema wearos. 

faça os ajustes necessários para que o aplicativo funcione como um gerenciador de tarefas.

deve ter uma tela principal, listando todas as tarefas, por ordem decrescente de criação. para cada tarefa deve ter um card, nesse card deve apresentar o nome da tarefa, parte da descrição (ocupando apenas uma linha de texto) e um ícone para indicar se ela foi ou não executada. se o usuário pressionar sobre uma determinada tarefa, ele deve ser direcionado para a tela de edição dos dados. se o usuário der um clique longo sobre a tarefa, deverá aparecer um diálogo, solicitando confirmação para marcar a tarefa como executada.

deve ter uma tela para permitir criar, editar e excluir tarefas. quando essa tela for acessada em formato edição, deve ser apresentado o botão para excluir, se ela for acessada em formato criação, o botão excluir não deve ser apresentado. ao clicar no botão de exclusão, deverá aparecer um diálogo, solicitando confirmação para o usuário excluir a tarefa.

uma tarefa é composta das seguintes informações:
- nome > nome da tarefa, campo de preenchimento obrigatório, campo de texto, suporta no máximo 30 caracteres
- descrição > descrição detalhada da tarefa, campo de preenchimento opcional, suporta no máximo 1000 caracteres
- executada > campo para indicar se a tarefa já foi ou não executada, campo do tipo boolean, o valor padrão é false, indicando que ela não foi executada
- data/hora do alarme > usuário poderia indicar uma data/hora futura e ao atingir essa data/hora deverá tocar um alarme no smartwatch, no alarme deve aparecer o nome da tarefa e ter um botão para interromper o alerme. o alarme deve tocar até que o usuário interrompa sua execução.

importante se preocupar com o layout, para que ele seja simples e responsivo e tenha uma boa usabilidade, visto que o aplicativo vai rodar em relógios, os quais possuem telas bem pequenas.

os dados do aplicativo devem ser armazenados localmente, sugiro utilizar o shared_preferences.

o aplicativo deve ser multi idioma, deve suportar os idiomas: portugues, ingles, espanhol, frances, chines e japones. o idioma default deve ser de acordo com o idioma do sistema operacional do dispositivo. 

deve ser possível trocar o tema do aplicativo: claro e escuro

o aplicativo deve ter uma tela splash screen, para ser apresentada ao abrir o aplicativo, nessa tela pode ter uma animação, para deixar o visual mais agradável