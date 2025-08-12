import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. DEFINIMOS EL MODELO DE DATOS PARA EL CLIENTE
class Client {
  final String id;
  final String name;
  final String avatarUrl;
  final DateTime joinDate;
  final List<Client> referrals;

  Client({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.joinDate,
    this.referrals = const [],
  });
}

// 2. CREAMOS LA PANTALLA PRINCIPAL
class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  // --- DATOS DE EJEMPLO CON ESTRUCTURA DE ÁRBOL ---
  final List<Client> _directClients = [
    Client(
      id: '001',
      name: 'Elena Rojas',
      avatarUrl: 'https://i.pravatar.cc/150?u=elena',
      joinDate: DateTime(2025, 1, 15),
      referrals: [
        Client(
          id: '101',
          name: 'Carlos Fallas',
          avatarUrl: 'https://i.pravatar.cc/150?u=carlos',
          joinDate: DateTime(2025, 2, 20),
          referrals: [
            Client(
              id: '201',
              name: 'Sofía Méndez',
              avatarUrl: 'https://i.pravatar.cc/150?u=sofia',
              joinDate: DateTime(2025, 3, 10),
            ),
          ],
        ),
        Client(
          id: '102',
          name: 'Luis Jiménez',
          avatarUrl: 'https://i.pravatar.cc/150?u=luis',
          joinDate: DateTime(2025, 2, 22),
        ),
      ],
    ),
    Client(
      id: '002',
      name: 'Mario Brenes',
      avatarUrl: 'https://i.pravatar.cc/150?u=mario',
      joinDate: DateTime(2025, 4, 5),
    ),
    Client(
      id: '003',
      name: 'Ana Vega',
      avatarUrl: 'https://i.pravatar.cc/150?u=ana',
      joinDate: DateTime(2025, 5, 1),
      referrals: [
        Client(
          id: '103',
          name: 'Pedro Soto',
          avatarUrl: 'https://i.pravatar.cc/150?u=pedro',
          joinDate: DateTime(2025, 6, 15),
        ),
      ],
    ),
  ];

  bool _genealogyView = false;

  int _countIndirectClients(List<Client> clients) {
    int count = 0;
    for (final client in clients) {
      count += client.referrals.length;
      count += _countIndirectClients(client.referrals);
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    final colorScheme = Theme.of(context).colorScheme;
    final int indirectClientsCount = _countIndirectClients(_directClients);
    final int totalClients = _directClients.length + indirectClientsCount;

    // =======================================================================
    // INICIO DE LA CORRECCIÓN ESTRUCTURAL
    // Usamos un Column en lugar de un ListView para el layout principal.
    // =======================================================================
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PARTE SUPERIOR ESTÁTICA (NO SE DESPLAZA) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Mis Clientes',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: _genealogyView
                        ? 'Cambiar a árbol vertical'
                        : 'Cambiar a vista genealógica',
                    child: IconButton(
                      onPressed: () =>
                          setState(() => _genealogyView = !_genealogyView),
                      icon: Icon(
                        _genealogyView
                            ? Icons.account_tree_outlined
                            : Icons.family_restroom,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    message: 'Añadir Cliente',
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person_add_alt_1),
                      label: const Text('Añadir'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.person_outline,
                      title: 'Clientes Directos',
                      value: _directClients.length.toString(),
                      color: const Color(0xFF00A8E8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.groups_outlined,
                      title: 'Clientes Indirectos',
                      value: indirectClientsCount.toString(),
                      color: const Color(0xFF9B5DE5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _genealogyView
                    ? 'Árbol Genealógico ($totalClients en total)'
                    : 'Árbol de Referidos ($totalClients en total)',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // --- ÁREA DE SCROLL ---
            // Expanded le da al área del árbol una altura finita y conocida.
            Expanded(child: _buildTreeContent()),
          ],
        ),
      ),
    );
  }

  /// Widget helper que construye el contenido del árbol apropiado.
  Widget _buildTreeContent() {
    if (_directClients.isEmpty) {
      return const Center(child: Text('Aún no tienes clientes directos.'));
    }

    if (_genealogyView) {
      // La vista genealógica ya es un SingleChildScrollView, por lo que puede vivir
      // dentro del Expanded sin problemas.
      return _GenealogyTreeRoot(
        title: 'Mis Clientes',
        children: _directClients,
      );
    } else {
      // La vista vertical necesita su propio ListView para ser desplazable.
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _directClients.length,
        itemBuilder: (context, index) {
          return _ClientTreeNode(client: _directClients[index]);
        },
      );
    }
  }
}

// 3A. WIDGET RECURSIVO PARA ÁRBOL VERTICAL
class _ClientTreeNode extends StatelessWidget {
  final Client client;
  final double indentation;
  final bool isLast;

  const _ClientTreeNode({
    required this.client,
    this.indentation = 0.0,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: indentation),
            if (indentation > 0)
              Text(
                isLast ? '└─ ' : '├─ ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                ),
              ),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(client.avatarUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Miembro desde: ${_formatDate(client.joinDate)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (client.referrals.isNotEmpty)
              Chip(
                avatar: Icon(
                  Icons.people,
                  size: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text('${client.referrals.length}'),
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.all(4),
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha((255 * 0.1).toInt()),
              ),
          ],
        ),
        if (client.referrals.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: indentation + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < client.referrals.length; i++)
                  _ClientTreeNode(
                    client: client.referrals[i],
                    indentation: 20.0,
                    isLast: i == client.referrals.length - 1,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

// 3B. VISTA DE ÁRBOL GENEALÓGICO CENTRADO
class _GenealogyTreeRoot extends StatelessWidget {
  final String title;
  final List<Client> children;

  const _GenealogyTreeRoot({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RootNode(
            title: title,
            icon: Icons.person_search,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          if (children.isNotEmpty)
            _ChildrenBlock(
              childCount: children.length,
              childBuilder: (i) => _GenealogyTreeNode(client: children[i]),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Sin clientes directos',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha((255 * 0.6).toInt()),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GenealogyTreeNode extends StatelessWidget {
  final Client client;

  const _GenealogyTreeNode({required this.client});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ClientNodeCard(client: client),
        const SizedBox(height: 8),
        if (client.referrals.isNotEmpty)
          _ChildrenBlock(
            childCount: client.referrals.length,
            childBuilder: (i) =>
                _GenealogyTreeNode(client: client.referrals[i]),
          ),
      ],
    );
  }
}

class _ChildrenBlock extends StatelessWidget {
  final int childCount;
  final Widget Function(int index) childBuilder;

  const _ChildrenBlock({required this.childCount, required this.childBuilder});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
            child: CustomPaint(
              painter: _ConnectorsPainter(
                childCount: childCount,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(childCount, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: childBuilder(i),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectorsPainter extends CustomPainter {
  final int childCount;
  final Color color;

  _ConnectorsPainter({required this.childCount, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (childCount == 0) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final top = 0.0;
    final midY = size.height * 0.35;
    final bottomY = size.height;

    canvas.drawLine(Offset(centerX, top), Offset(centerX, midY), paint);

    if (childCount > 1) {
      final firstChildX = size.width / (childCount * 2);
      final lastChildX = size.width - firstChildX;
      canvas.drawLine(
        Offset(firstChildX, midY),
        Offset(lastChildX, midY),
        paint,
      );
    }

    for (int i = 0; i < childCount; i++) {
      final childX = (i + 0.5) * size.width / childCount;
      canvas.drawLine(Offset(childX, midY), Offset(childX, bottomY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConnectorsPainter oldDelegate) {
    return oldDelegate.childCount != childCount || oldDelegate.color != color;
  }
}

class _ClientNodeCard extends StatelessWidget {
  final Client client;

  const _ClientNodeCard({required this.client});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: const BoxConstraints(minWidth: 150),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withAlpha((255 * 0.05).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(client.avatarUrl),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  client.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Desde ${_formatDate(client.joinDate)}',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (client.referrals.isNotEmpty) ...[
            const SizedBox(width: 8),
            Chip(
              avatar: Icon(Icons.people, size: 14, color: cs.primary),
              label: Text('${client.referrals.length}'),
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.all(4),
              backgroundColor: cs.primary.withAlpha((255 * 0.1).toInt()),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ],
      ),
    );
  }
}

class _RootNode extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _RootNode({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withAlpha((255 * 0.15).toInt()),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withAlpha((255 * 0.15).toInt()),
            radius: 20,
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// FUNCIÓN GLOBAL PARA FORMATEAR FECHAS
String _formatDate(DateTime d) {
  return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
