import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/detalhes_paciente.dart';
import 'package:reabilita_social/screens/form_categoria.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/widgets/botao/botaoPrincipal.dart';



class PacienteScreen extends StatefulWidget {
  const PacienteScreen({super.key});

  @override
  _PacienteScreenState createState() => _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        title: const Text(
          'Paciente Sara',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildCardPaciente(
              context,
              icon: Icons.person,
              text: 'Dados do Paciente',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhesPaciente(
                            nomePaciente: 'Fernanda da Silva',
                            dataCriacao: '04/07/2024',
                            titulo: 'Dados do Paciente',
                            categoria: 'Categoria X',
                            conteudos: [
                              ItemConteudo(
                                  titulo: 'Dados Pessoais',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Nome Completo',
                                                hintText: 'Fernanda da Silva',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Idade',
                                                hintText: '30',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Gênero',
                                                hintText: 'Feminino',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'CNS',
                                                hintText: 'XXXXXXXXXXXXXX',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Profissão',
                                                hintText: 'Lorem',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Renda Mensal',
                                                hintText: 'R\$ XXXX,XX',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'CEP',
                                                hintText: 'XXXXX-XXX',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Bairro',
                                                hintText: 'Lorem Ipsum',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Logradouro',
                                                hintText: 'Rua XXXXXX',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Número',
                                                hintText: '123',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Cidade',
                                                hintText: 'Cidade X',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Estado',
                                                hintText: 'Estado Y',
                                                widthFactor: 0.5),
                                          ],
                                          titulo: 'Dados Pessoais',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Outras Informações',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label:
                                                    'Principal Rede de Apoio/Suporte do Paciente',
                                                hintText:
                                                    'Nomes, contatos, endereços',
                                                widthFactor: 1.0,
                                                isDoubleHeight: true),
                                            FieldConfig(
                                                label: 'Paciente Curatelado?',
                                                hintText:
                                                    'Paciente Curatelado?',
                                                widthFactor: 1,
                                                isRadioField: true),
                                            FieldConfig(
                                                label: 'Técnico de Referência',
                                                hintText: 'Dr. Lorem Ipsum',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Outras Informações',
                                                hintText:
                                                    'Observações sobre o paciente',
                                                widthFactor: 1.0,
                                                isDoubleHeight: true),
                                          ],
                                          titulo: 'Outras Informações',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                            ],
                          )),
                );
              },
            ),
            buildCardPaciente(
              context,
              icon: Icons.assignment,
              text: 'Diagnóstico situacional em saúde mental',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhesPaciente(
                            nomePaciente: 'Fernanda da Silva',
                            dataCriacao: '04/07/2024',
                            titulo: 'Diagnóstico situacional em saúde mental',
                            categoria: 'Categoria X',
                            conteudos: [
                              ItemConteudo(
                                  titulo:
                                      'História do caso e Diagnósticos Multiprofissionais',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'História do Caso',
                                                hintText:
                                                    'Descreva a história do caso',
                                                widthFactor: 1.0,
                                                isDoubleHeight: true),
                                            FieldConfig(
                                                label:
                                                    'Diagnósticos Multiprofissionais',
                                                hintText:
                                                    'Diagnósticos Multiprofissionais do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                              label: 'Imagens do Paciente',
                                              hintText: '',
                                              isImageField: true,
                                              images: [
                                                const AssetImage(''),
                                                const AssetImage(''),
                                                const NetworkImage(''),
                                                const NetworkImage(''),
                                              ],
                                            ),
                                          ],
                                          titulo:
                                              'História do caso e Diagnósticos Multiprofissionais',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Recursos Individuais e Habilidades',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Recursos Individuais',
                                                hintText:
                                                    'Recursos Individuais do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Habilidades',
                                                hintText:
                                                    'Habilidades do paciente',
                                                widthFactor: 1.0),
                                          ],
                                          titulo:
                                              'Recursos Individuais e Habilidades',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Potencialidades',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Potencialidades',
                                                hintText:
                                                    'Potencialidades do paciente',
                                                widthFactor: 1.0)
                                          ],
                                          titulo: 'Potencialidades',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Desejo e Sonhos de Vida',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Desejos',
                                                hintText: 'Desejos do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Sonhos de Vida',
                                                hintText:
                                                    'Sonhos de Vida do paciente',
                                                widthFactor: 1.0)
                                          ],
                                          titulo: 'Desejos e Sonhos de Vida',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo:
                                      'Dificuldades Pessoais, Coletivas e Estruturais',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Recursos Individuais',
                                                hintText:
                                                    'Recursos Individuais do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Habilidades',
                                                hintText:
                                                    'Habilidades do paciente',
                                                widthFactor: 1.0)
                                          ],
                                          titulo:
                                              'Dificuldades Pessoais, Coletivas e Estruturais',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Medicação em Uso',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Medicações',
                                                hintText: 'Medicações em Uso',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'ML',
                                                hintText: '',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Uso',
                                                hintText: '',
                                                widthFactor: 0.5),
                                          ],
                                          titulo: 'Medicação em Uso',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Doenças Clínicas',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Doenças Clínicas',
                                                hintText:
                                                    'Doenças Clínicas do paciente',
                                                widthFactor: 1.0),
                                          ],
                                          titulo: 'Doenças Clínicas',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Outras Informações',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Informações',
                                                hintText:
                                                    'Informações do paciente',
                                                widthFactor: 1.0,
                                                isDoubleHeight: true),
                                          ],
                                          titulo: 'Outras Informações',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                            ],
                          )),
                );
              },
            ),
            buildCardPaciente(
              context,
              icon: Icons.flag,
              text: 'Metas de cuidado em saúde mental',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhesPaciente(
                            nomePaciente: 'Fernanda da Silva',
                            dataCriacao: '04/07/2024',
                            titulo: 'Metas de cuidado em saúde mental',
                            categoria: 'Categoria X',
                            conteudos: [
                              ItemConteudo(
                                  titulo:
                                      'Metas a Curto Prazo (Inferiores a 2 meses)',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Meta 1',
                                                hintText: 'Meta 1 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Meta 2',
                                                hintText: 'Meta 2 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Meta 3',
                                                hintText: 'Meta 3 do paciente',
                                                widthFactor: 1.0),
                                          ],
                                          titulo:
                                              'Metas a Curto Prazo (Inferiores a 2 meses)',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Metas a Médio Prazo (Até 6 meses)',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Meta 1',
                                                hintText: 'Meta 1 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Meta 2',
                                                hintText: 'Meta 2 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Meta 3',
                                                hintText: 'Meta 3 do paciente',
                                                widthFactor: 1.0),
                                          ],
                                          titulo:
                                              'Metas a Médio Prazo (Até 6 meses)',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Metas a Longo Prazo (Até 12 meses)',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Meta 1',
                                                hintText: 'Meta 1 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Meta 2',
                                                hintText: 'Meta 2 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Meta 3',
                                                hintText: 'Meta 3 do paciente',
                                                widthFactor: 1.0),
                                          ],
                                          titulo:
                                              'Metas a Longo Prazo (Até 12 meses)',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                            ],
                          )),
                );
              },
            ),
            buildCardPaciente(
              context,
              icon: Icons.medical_services,
              text: 'Intervenções em saúde mental',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhesPaciente(
                            nomePaciente: 'Fernanda da Silva',
                            dataCriacao: '04/07/2024',
                            titulo: 'Intervenções em saúde mental',
                            categoria: 'Categoria X',
                            conteudos: [
                              ItemConteudo(
                                  titulo: 'Intervenção - 01/05/2013',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Intervenção 1',
                                                hintText:
                                                    'Intervenção 1 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Intervenção 2',
                                                hintText:
                                                    'Intervenção 2 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Intervenção 3',
                                                hintText:
                                                    'Intervenção 3 do paciente',
                                                widthFactor: 1.0),
                                          ],
                                          titulo: 'Intervenção - 01/05/2013',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                              ItemConteudo(
                                  titulo: 'Intervenção - 03/07/2018',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Intervenção 1',
                                                hintText:
                                                    'Intervenção 1 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Intervenção 2',
                                                hintText:
                                                    'Intervenção 2 do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Intervenção 3',
                                                hintText:
                                                    'Intervenção 3 do paciente',
                                                widthFactor: 1.0),
                                          ],
                                          titulo: 'Intervenção - 01/05/2013',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                            ],
                          )),
                );
              },
            ),
            buildCardPaciente(
              context,
              icon: Icons.people,
              text: 'Pactuações',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhesPaciente(
                            nomePaciente: 'Fernanda da Silva',
                            dataCriacao: '04/07/2024',
                            titulo: 'Pactuações',
                            categoria: 'Categoria X',
                            conteudos: [
                              ItemConteudo(
                                  titulo: 'Pactuação realizada em 01/05/2013',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Paciente Psiquiátrico',
                                                hintText:
                                                    'Paciente Psiquiátrico',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label:
                                                    'Responsáveis pela Intervenção',
                                                hintText:
                                                    'Responsáveis pela Intervenção do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Prazo',
                                                hintText: 'Prazo do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Família',
                                                hintText: 'Família do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label:
                                                    'Responsáveis pela Intervenção',
                                                hintText:
                                                    'Responsáveis pela Intervenção do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Prazo',
                                                hintText: 'Prazo do paciente',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                              label: 'Ata da Pactuação',
                                              hintText: '',
                                              isImageField: true,
                                              images: [
                                                const AssetImage(''),
                                              ],
                                            ),
                                          ],
                                          titulo:
                                              'Pactuação realizada em 01/05/2013',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                            ],
                          )),
                );
              },
            ),
            buildCardPaciente(
              context,
              icon: Icons.calendar_today,
              text: 'Agenda de Estudo de Caso',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhesPaciente(
                            nomePaciente: 'Fernanda da Silva',
                            dataCriacao: '04/07/2024',
                            titulo: 'Agenda de Estudo de Caso',
                            categoria: 'Categoria X',
                            conteudos: [
                              ItemConteudo(
                                  titulo:
                                      'Agenda de estudo realizada em 01/05/2013',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Data da Reunião',
                                                hintText: '00/00/0000',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label: 'Pauta',
                                                hintText: 'pauta da reuniao',
                                                widthFactor: 0.5),
                                            FieldConfig(
                                                label:
                                                    'Quem é necessário participar?',
                                                hintText: 'Nomes',
                                                widthFactor: 1.0,
                                                isDoubleHeight: true),
                                          ],
                                          titulo:
                                              'Pactuação realizada em 01/05/2013',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                            ],
                          )),
                );
              },
            ),
            buildCardPaciente(
              context,
              icon: Icons.assessment,
              text: 'Avaliação do Projeto de Reabilitação Psicossocial',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhesPaciente(
                            nomePaciente: 'Fernanda da Silva',
                            dataCriacao: '04/07/2024',
                            titulo: 'Avaliação do PRP',
                            categoria: 'Categoria X',
                            conteudos: [
                              ItemConteudo(
                                  titulo:
                                      'Avaliação Programada do PRP (A CADA 2 MESES) - 01/05/2013',
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => FormCategoria(
                                          fields: [
                                            FieldConfig(
                                                label: 'Intervenção/Pactuação',
                                                hintText: 'Nome da Intervenção',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                                label: 'Responsável?',
                                                hintText: 'Nomes',
                                                widthFactor: 1.0),
                                            FieldConfig(
                                              label: 'Cumpriu Totalmente',
                                              hintText: '',
                                              isRadioField: true,
                                            ),
                                            FieldConfig(
                                              label: 'Cumpriu Parcialmente',
                                              hintText: '',
                                              isRadioField: true,
                                            ),
                                            FieldConfig(
                                              label: 'Não Cumpriu',
                                              hintText: '',
                                              isRadioField: true,
                                            ),
                                            FieldConfig(
                                                label: 'Observação',
                                                hintText:
                                                    'Observação do Paciente',
                                                widthFactor: 1.0,
                                                isDoubleHeight: true),
                                            FieldConfig(
                                              label: 'Imagens do Paciente',
                                              hintText: '',
                                              isImageField: true,
                                              images: [
                                                const AssetImage(''),
                                                const AssetImage(''),
                                                const NetworkImage(''),
                                                const NetworkImage(''),
                                              ],
                                            ),
                                          ],
                                          titulo:
                                              'Avaliação Programada do PRP (A CADA 2 MESES) - 01/05/2013',
                                        ),
                                      )),
                                  onTap2: () {
                                    print("oi");
                                  }),
                            ],
                          )),
                );
              },
            ),
            const Spacer(),
            Botaoprincipal(text: 'Compartilhar Projeto', onPressed: () {})
          ],
        ),
      ),
    );
  }

  Widget buildCardPaciente(BuildContext context,
      {required IconData icon, required String text, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[100],
              ),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
