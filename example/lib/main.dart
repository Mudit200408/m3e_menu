// Copyright (c) 2026 Mudit Purohit
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import 'package:flutter/material.dart';
import 'package:m3e_buttons/m3e_buttons.dart' hide M3EMotion;
import 'package:m3e_menu/m3e_menu.dart';

void main() {
  runApp(const M3EMenuExampleApp());
}

class M3EMenuExampleApp extends StatefulWidget {
  const M3EMenuExampleApp({super.key});

  @override
  State<M3EMenuExampleApp> createState() => _M3EMenuExampleAppState();
}

class _M3EMenuExampleAppState extends State<M3EMenuExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M3E Menu Showcase',
      themeMode: _themeMode,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: M3EMenuShowcaseScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class M3EMenuShowcaseScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const M3EMenuShowcaseScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<M3EMenuShowcaseScreen> createState() => _M3EMenuShowcaseScreenState();
}

class _M3EMenuShowcaseScreenState extends State<M3EMenuShowcaseScreen> {
  final M3EMenuController _fileMenuController = M3EMenuController();
  final M3EMenuController _optionsMenuController = M3EMenuController();
  final M3EMenuController _styledMenuController = M3EMenuController();

  // Settings & state
  bool _showLineNumbers = true;
  bool _autoSave = true;
  bool _wordWrap = false;
  String _layoutDensity = 'Comfortable';
  String _lastEvent = 'No actions performed yet';

  // Configurable Playground State
  M3EMenuPosition _selectedPosition = M3EMenuPosition.under;
  M3EMenuAnimationStyle _selectedAnimStyle = M3EMenuAnimationStyle.popup;
  double _elevation = 3.0;
  String _motionPreset = 'Expressive Fast';

  M3EMotion get _currentMotion {
    switch (_motionPreset) {
      case 'Expressive Slow':
        return M3EMotion.expressiveSpatialSlow;
      case 'Standard Default':
        return M3EMotion.standardSpatialDefault;
      case 'Standard Fast':
        return M3EMotion.standardSpatialFast;
      case 'Expressive Fast':
      default:
        return M3EMotion.expressiveSpatialFast;
    }
  }

  void _log(String message) {
    setState(() {
      _lastEvent =
          '${DateTime.now().toIso8601String().substring(11, 19)} - $message';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 Expressive Menus'),
        elevation: 1,
        actions: [
          IconButton(
            tooltip: widget.isDarkMode ? 'Switch to Light' : 'Switch to Dark',
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            onPressed: widget.onToggleTheme,
          ),
          // Showcase M3EPopupMenuButton in AppBar
          M3EPopupMenuButton<String>(
            tooltip: 'Overflow Options',
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (val) => _log('AppBar menu action: $val'),
            itemBuilder: (context) => [
              const M3EPopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 20),
                    SizedBox(width: 12),
                    Text('Settings'),
                  ],
                ),
              ),
              const M3EPopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, size: 20),
                    SizedBox(width: 12),
                    Text('About M3E Menu'),
                  ],
                ),
              ),
              const M3EPopupMenuDivider(),
              const M3EPopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded, size: 20, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Sign out', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Banner
                _buildHeader(cs),
                const SizedBox(height: 20),

                // Event Logger Card
                _buildEventLogger(cs),
                const SizedBox(height: 24),

                // Section 1: Standard & Cascading Submenu
                _buildCardSection(
                  title: '1. Cascading Menus & Submenus',
                  subtitle: 'Powered by Magic Triangle safe-hover navigation, spring physics motion, and submenus.',
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // File Menu with Cascading Submenus
                      M3EMenuAnchor(
                        controller: _fileMenuController,
                        menuChildren: [
                          M3EMenuGroup(
                            children: [
                              M3EMenuItemButton(
                                leadingIcon: const Icon(
                                  Icons.file_open_outlined,
                                  size: 20,
                                ),
                                trailingIcon: const Text(
                                  '⌘O',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: () => _log('File -> Open selected'),
                                child: const Text('Open File...'),
                              ),
                              M3EMenuItemButton(
                                leadingIcon: const Icon(
                                  Icons.save_outlined,
                                  size: 20,
                                ),
                                trailingIcon: const Text(
                                  '⌘S',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: () => _log('File -> Save selected'),
                                child: const Text('Save'),
                              ),
                              // Cascading Submenu 1
                              M3ESubmenuButton(
                                leadingIcon: const Icon(
                                  Icons.ios_share_outlined,
                                  size: 20,
                                ),
                                menuChildren: [
                                  M3EMenuItemButton(
                                    leadingIcon: const Icon(
                                      Icons.picture_as_pdf_outlined,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        _log('Export -> PDF selected'),
                                    child: const Text('Export as PDF'),
                                  ),
                                  M3EMenuItemButton(
                                    leadingIcon: const Icon(
                                      Icons.image_outlined,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        _log('Export -> PNG selected'),
                                    child: const Text('Export as PNG'),
                                  ),
                                  // Nested Level 2 Submenu
                                  M3ESubmenuButton(
                                    leadingIcon: const Icon(
                                      Icons.code_rounded,
                                      size: 20,
                                    ),
                                    menuChildren: [
                                      M3EMenuItemButton(
                                        onPressed: () => _log(
                                          'Export -> Code -> JSON selected',
                                        ),
                                        child: const Text('JSON Schema'),
                                      ),
                                      M3EMenuItemButton(
                                        onPressed: () => _log(
                                          'Export -> Code -> YAML selected',
                                        ),
                                        child: const Text('YAML Config'),
                                      ),
                                    ],
                                    child: const Text('Export as Code'),
                                  ),
                                ],
                                child: const Text('Export As'),
                              ),
                            ],
                          ),
                          const M3EMenuGroupLabel(child: Text('Danger Zone')),
                          M3EMenuGroup(
                            children: [
                              M3EMenuItemButton(
                                leadingIcon: const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                onPressed: () => _log('Delete File selected'),
                                child: const Text(
                                  'Delete File',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                        builder: (context, controller, child) {
                          return M3EButton(
                            style: M3EButtonStyle.filled,
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.folder_outlined, size: 18),
                                SizedBox(width: 8),
                                Text('File Actions (Cascading)'),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // Standalone Submenu popup button
                      M3EButton(
                        style: M3EButtonStyle.tonal,
                        onPressed: () => _fileMenuController.isOpen
                            ? _fileMenuController.close()
                            : _fileMenuController.open(),
                        child: Text(
                          _fileMenuController.isOpen
                              ? 'Close Menu'
                              : 'Open Programmatically',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Section 2: Segmented Groups with Checkbox and Radio items
                _buildCardSection(
                  title: '2. Checkbox & Radio Menu Items',
                  subtitle: 'Segmented visual groups with morphing shapes, multi-select checkboxes, and single-select radios.',
                  child: M3EMenuAnchor(
                    controller: _optionsMenuController,
                    menuChildren: [
                      const M3EMenuGroupLabel(
                        child: Text('Display Preferences'),
                      ),
                      M3EMenuGroup(
                        children: [
                          M3ECheckboxMenuButton(
                            value: _showLineNumbers,
                            onChanged: (val) {
                              setState(() => _showLineNumbers = val ?? false);
                              _log('Line Numbers: $_showLineNumbers');
                            },
                            leadingIcon: const Icon(
                              Icons.format_list_numbered_rounded,
                              size: 20,
                            ),
                            child: const Text('Show line numbers'),
                          ),
                          M3ECheckboxMenuButton(
                            value: _autoSave,
                            onChanged: (val) {
                              setState(() => _autoSave = val ?? false);
                              _log('Auto Save: $_autoSave');
                            },
                            leadingIcon: const Icon(
                              Icons.sync_rounded,
                              size: 20,
                            ),
                            child: const Text('Auto-save changes'),
                          ),
                          M3ECheckboxMenuButton(
                            value: _wordWrap,
                            onChanged: (val) {
                              setState(() => _wordWrap = val ?? false);
                              _log('Word Wrap: $_wordWrap');
                            },
                            leadingIcon: const Icon(
                              Icons.wrap_text_rounded,
                              size: 20,
                            ),
                            child: const Text('Soft wrap lines'),
                          ),
                        ],
                      ),
                      const M3EMenuGroupLabel(child: Text('Layout Density')),
                      M3EMenuGroup(
                        children: [
                          M3ERadioMenuButton<String>(
                            value: 'Compact',
                            groupValue: _layoutDensity,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _layoutDensity = val);
                                _log('Density set to: $val');
                              }
                            },
                            leadingIcon: const Icon(
                              Icons.density_small_rounded,
                              size: 20,
                            ),
                            child: const Text('Compact'),
                          ),
                          M3ERadioMenuButton<String>(
                            value: 'Comfortable',
                            groupValue: _layoutDensity,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _layoutDensity = val);
                                _log('Density set to: $val');
                              }
                            },
                            leadingIcon: const Icon(
                              Icons.density_medium_rounded,
                              size: 20,
                            ),
                            child: const Text('Comfortable (Default)'),
                          ),
                          M3ERadioMenuButton<String>(
                            value: 'Spacious',
                            groupValue: _layoutDensity,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _layoutDensity = val);
                                _log('Density set to: $val');
                              }
                            },
                            leadingIcon: const Icon(
                              Icons.density_large_rounded,
                              size: 20,
                            ),
                            child: const Text('Spacious'),
                          ),
                        ],
                      ),
                    ],
                    builder: (context, controller, child) {
                      return M3EButton(
                        style: M3EButtonStyle.outlined,
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.tune_rounded, size: 18),
                            const SizedBox(width: 8),
                            Text('Editor Settings ($_layoutDensity)'),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Section 3: Interactive Playground / Configurable Style
                _buildCardSection(
                  title: '3. Interactive Style & Motion Playground',
                  subtitle: 'Test different spring physics, reveal animation styles, elevation, and anchor alignment.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 24,
                        runSpacing: 16,
                        children: [
                          // Position Selection
                          _buildDropdownSelector<M3EMenuPosition>(
                            label: 'Menu Position',
                            value: _selectedPosition,
                            items: const [
                              DropdownMenuItem(
                                value: M3EMenuPosition.under,
                                child: Text('under (Default)'),
                              ),
                              DropdownMenuItem(
                                value: M3EMenuPosition.over,
                                child: Text('over (Center)'),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedPosition = val);
                              }
                            },
                          ),

                          // Animation Style
                          _buildDropdownSelector<M3EMenuAnimationStyle>(
                            label: 'Animation Style',
                            value: _selectedAnimStyle,
                            items: const [
                              DropdownMenuItem(
                                value: M3EMenuAnimationStyle.popup,
                                child: Text('popup (Scale & Fade Elastic Pop)'),
                              ),
                              DropdownMenuItem(
                                value: M3EMenuAnimationStyle.dropdown,
                                child: Text(
                                  'dropdown (Vertical Reveal Unroll)',
                                ),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedAnimStyle = val);
                              }
                            },
                          ),

                          // Motion Preset
                          _buildDropdownSelector<String>(
                            label: 'Spring Motion Preset',
                            value: _motionPreset,
                            items: const [
                              DropdownMenuItem(
                                value: 'Expressive Fast',
                                child: Text('Expressive Fast'),
                              ),
                              DropdownMenuItem(
                                value: 'Expressive Slow',
                                child: Text('Expressive Slow'),
                              ),
                              DropdownMenuItem(
                                value: 'Standard Default',
                                child: Text('Standard Default'),
                              ),
                              DropdownMenuItem(
                                value: 'Standard Fast',
                                child: Text('Standard Fast'),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _motionPreset = val);
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Elevation Slider
                      Row(
                        children: [
                          Text('Elevation (${_elevation.toStringAsFixed(1)}):'),
                          Expanded(
                            child: Slider(
                              value: _elevation,
                              min: 0,
                              max: 12,
                              divisions: 12,
                              onChanged: (val) =>
                                  setState(() => _elevation = val),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Launch configured menu button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: M3EMenuAnchor(
                          controller: _styledMenuController,
                          style: M3EMenuStyle(
                            position: _selectedPosition,
                            animationStyle: _selectedAnimStyle,
                            spatialMotion: _currentMotion,
                            elevation: _elevation,
                          ),
                          menuChildren: [
                            M3EMenuGroup(
                              children: [
                                M3EMenuItemButton(
                                  leadingIcon: const Icon(
                                    Icons.rocket_launch_outlined,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      _log('Playground: Launch clicked'),
                                  child: const Text('Launch Preview'),
                                ),
                                M3EMenuItemButton(
                                  leadingIcon: const Icon(
                                    Icons.refresh_rounded,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      _log('Playground: Reset clicked'),
                                  child: const Text('Reset Settings'),
                                ),
                                M3EMenuItemButton(
                                  leadingIcon: const Icon(
                                    Icons.share_outlined,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      _log('Playground: Share clicked'),
                                  child: const Text('Share Result'),
                                ),
                              ],
                            ),
                          ],
                          builder: (context, controller, child) {
                            return M3EButton(
                              style: M3EButtonStyle.elevated,
                              onPressed: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.play_arrow_rounded, size: 18),
                                  SizedBox(width: 8),
                                  Text('Open Customized Menu'),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.widgets_rounded, color: cs.primary, size: 28),
              const SizedBox(width: 12),
              Text(
                'M3E Menu Component Showcase',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Explore Material 3 Expressive menus with spring-physics motion, '
            'Magic Triangle safe traversal, morphing group shapes, and check/radio items.',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildEventLogger(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.terminal_rounded, size: 18, color: cs.primary),
          const SizedBox(width: 10),
          Text(
            'Latest Event: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: cs.primary,
            ),
          ),
          Expanded(
            child: Text(
              _lastEvent,
              style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
            ),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSelector<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        DropdownButton<T>(value: value, items: items, onChanged: onChanged),
      ],
    );
  }
}
