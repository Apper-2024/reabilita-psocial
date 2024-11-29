import 'package:flutter/material.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import 'package:reabilita_social/utils/colors.dart';
import 'package:reabilita_social/utils/responsive.dart';
import 'package:reabilita_social/widgets/inputText/text_search.dart';

class TituloPrincipal extends StatefulWidget {
  final String titulo;
  final List<String> items;
  final bool pesquisa;
  final Function(String)? onChanged;

  const TituloPrincipal({
    super.key,
    required this.titulo,
    required this.items,
    required this.pesquisa,
    this.onChanged,
  });

  @override
  _TituloPrincipalState createState() => _TituloPrincipalState();
}

class _TituloPrincipalState extends State<TituloPrincipal> {
  void _navigateToScreen(BuildContext context, String value) {
    switch (value) {
      case 'Sair':
        AuthRepository().signOut();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double dropdownWidth = constraints.maxWidth * 0.2;
        double searchWidth = constraints.maxWidth * 0.4;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (Responsive.isDesktop(context))
              Text(
                widget.titulo,
                style: const TextStyle(color: preto1, fontSize: 24, fontWeight: FontWeight.w700),
              ),
            const Spacer(),
            if (!Responsive.isMobile(context))
              Visibility(
                visible: widget.pesquisa,
                child: SizedBox(
                  width: searchWidth.clamp(200, 380),
                  height: 50,
                  child: TextSearch(
                    hintText: 'Procure o nome do profissional',
                    onChanged: widget.onChanged,
                  ),
                ),
              ),
            if (!Responsive.isMobile(context))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: dropdownWidth.clamp(150, 250),
                  height: 50,
                  decoration: const BoxDecoration(
                    color: branco,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: DropdownButton<String>(
                      focusColor: Colors.transparent,
                      padding: const EdgeInsets.all(8),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Popins', color: preto1),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      dropdownColor: branco,
                      value: widget.items.first,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          // setState(() {
                          //   _selectedValue = newValue;
                          // });
                          _navigateToScreen(context, newValue);
                        }
                      },
                      items: widget.items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
